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

    // Now safe to call since context is under MultiBlocProvider
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

    print('Incoming URI: $uri');

    if (uri.path == '/reset-password' &&
        uri.queryParameters.containsKey('token')) {
      final token = uri.queryParameters['token'];
      if (token != null) {
        // Use navigatorKey to push instead of context
        // navigatorKey.currentState?.push(
        //   MaterialPageRoute(
        //     builder: (_) => const LoginScreen(),
        //     settings: RouteSettings(
        //       arguments: {'token': token, 'showForgotPasswordSheet': true},
        //     ),
        //   ),
        // );
        navigatorKey.currentState?.pushNamed(AppRouter.login, arguments: {
          'token': token,
          'showForgotPasswordSheet': true,
        });
      }
    }
  }

  @override
  void dispose() {
    BlocManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 12 Pro size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          title: 'Parent Wish',
          theme: ThemeData(
            textTheme: GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
          ),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              print('bloc state is: $state');

              if (state is AuthLoading) {
                return const SplashScreen();
              }

              if (state is AuthInitial || state is AuthUnauthenticated) {
                // return const SplashScreen();
                return const AddTaskScreen();
              }

              if (state is AuthAuthenticated) {
                return const HomeScreen();
              }

              return const SplashScreen(); // safe fallback
            },
          ),
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
