import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parent_wish/bloc/app_bloc_observer.dart';
import 'package:parent_wish/bloc/auth_bloc/auth_bloc.dart';
import 'package:parent_wish/bloc/bloc_exports.dart';
import 'package:parent_wish/bloc/bloc_manager.dart';
import 'package:parent_wish/ui/screens/add_children_screen.dart';
import 'package:parent_wish/ui/screens/index.dart';
import 'package:parent_wish/utils/routers.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Bloc observer
  Bloc.observer = AppBlocObserver();

  runApp(const ParentWish());
}

class ParentWish extends StatefulWidget {
  const ParentWish({super.key});

  @override
  State<ParentWish> createState() => _ParentWishState();
}

class _ParentWishState extends State<ParentWish> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocManager.blocProviders,
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // iPhone 12 Pro size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Parent Wish',
            theme: ThemeData(
              textTheme:
                  GoogleFonts.outfitTextTheme(Theme.of(context).textTheme),
            ),
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const SplashScreen(); // show loader during auth checking
                }

                // First time open app or logged out
                if (state is AuthInitial || state is AuthUnauthenticated) {
                  // return const SplashScreen(); // welcome screen with buttons
                  return const ListChildrenScreen(); // welcome screen with buttons
                }

                // After successful login
                if (state is AuthAuthenticated) {
                  return const HomeScreen();
                }

                // If error or unknown state
                return const SplashScreen(); // safe fallback
              },
            ),
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    BlocManager.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
