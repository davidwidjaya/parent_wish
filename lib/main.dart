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

class ParentWish extends StatefulWidget {
  const ParentWish({super.key});

  @override
  State<ParentWish> createState() => _ParentWishState();
}

class _ParentWishState extends State<ParentWish> {
  @override
  void initState() {
    super.initState();

    // Now safe to call since context is under MultiBlocProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthCheckLoggedIn());
    });
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
                return const SplashScreen();
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
