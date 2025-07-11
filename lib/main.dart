import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_wish/bloc/app_bloc_observer.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/bloc/bloc_exports.dart';
import 'package:parent_wish/bloc/bloc_manager.dart';
import 'package:parent_wish/ui/screens/index.dart';
import 'package:parent_wish/utils/routers.dart';
import 'package:app_links/app_links.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Bloc observer
  Bloc.observer = AppBlocObserver();

  runApp(
    MultiBlocProvider(
      providers: BlocManager.blocProviders,
      child: const ParentWish(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ParentWish extends StatefulWidget {
  const ParentWish({super.key});

  @override
  State<ParentWish> createState() => _ParentWishState();
}

class _ParentWishState extends State<ParentWish> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthCheckLoggedIn());
    });

    _initAppLinkListener();
  }

  void _initAppLinkListener() async {
    try {
      final uri = await _appLinks.getInitialLink();
      _handleIncomingLink(uri);

      _appLinks.uriLinkStream.listen((Uri? uri) {
        _handleIncomingLink(uri);
      });
    } catch (e) {
      print('Error getting initial link: $e');
    }
  }

  void _handleIncomingLink(Uri? uri) {
    if (uri == null) return;

    if (uri.path == '/reset-password' &&
        uri.queryParameters.containsKey('token')) {
      final token = uri.queryParameters['token'];
      if (token != null) {
        navigatorKey.currentState?.pushNamed(AppRouter.login, arguments: {
          'token': token,
          'showForgotPasswordSheet': true,
        });
      }
    }
  }

  void _handleRedirectByStep() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user') ?? '{}';
    final user = jsonDecode(userString);

    final step = user['step'];
    print('stepxx: ');
    print(step);
    if (step == 'step_completed') {
      navigatorKey.currentState?.pushReplacementNamed(AppRouter.home);
    } else {
      navigatorKey.currentState?.pushReplacementNamed(AppRouter.splash);
      // return const SplashScreen();
    }
    // if (step == 'step_verif_code') {
    //   navigatorKey.currentState
    //       ?.pushReplacementNamed(AppRouter.verificationEmail);
    // } else if (step == 'step_edit_profile') {
    //   navigatorKey.currentState
    //       ?.pushReplacementNamed(AppRouter.completeProfile);
    // } else if (step == 'step_completed') {
    //   navigatorKey.currentState?.pushReplacementNamed(AppRouter.home);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Parent Wish',
          theme: ThemeData(
            textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
          ),
          home: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              print("AuthBloc listener triggered: $state");

              if (state is AuthAuthenticated) {
                print("Redirecting by step...");
                _handleRedirectByStep();
              }

              if (state is AuthUnauthenticated) {
                print("Navigating to splash screen...");
                navigatorKey.currentState?.pushNamedAndRemoveUntil(
                  AppRouter.splash,
                  (route) => false,
                );
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) return const SplashScreen();
                if (state is AuthUnauthenticated || state is AuthInitial) {
                  return const SplashScreen();
                }
                if (state is AuthAuthenticated) {
                  // Show a temporary screen while waiting for _handleRedirectByStep
                  return const SplashScreen();
                }

                return const SplashScreen();
              },
            ),
          ),
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }

  @override
  void dispose() {
    BlocManager.dispose();
    super.dispose();
  }
}
