import 'package:flutter/material.dart';
import 'package:parent_wish/ui/screens/index.dart';

class AppRouter {
  static const String register = '/register';
  static const String splash = '/splash';
  static const String addChildren = '/add_children';
  static const String listChildren = '/list_children';
  static const String login = '/login';
  static const String completeProfile = '/complete_profile';
  static const String verificationEmail = '/verification_email';
  static const String home = '/home';

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case addChildren:
        return MaterialPageRoute(
          builder: (_) => const AddChildrenScreen(),
        );
      case listChildren:
        return MaterialPageRoute(
          builder: (_) => const ListChildrenScreen(),
        );
      case completeProfile:
        return MaterialPageRoute(
          builder: (_) => const CompleteProfileScreen(),
        );
      case verificationEmail:
        return MaterialPageRoute(
          builder: (_) => const VerificationEmailScreen(),
        );
      case login:
        final args = settings.arguments;

        String? token;
        bool showForgotPasswordSheet = false;

        // final Map<String, dynamic> data =
        //     settings.arguments as Map<String, dynamic>;

        if (args != null && args is Map<String, dynamic>) {
          token = args['token'] as String?;
          showForgotPasswordSheet =
              args['showForgotPasswordSheet'] as bool? ?? false;
        }

        return MaterialPageRoute(
          builder: (_) => LoginScreen(
            token: token,
            showForgotPasswordSheet: showForgotPasswordSheet,
          ),
          settings: settings,
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
