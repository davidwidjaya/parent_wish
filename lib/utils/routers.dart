import 'package:flutter/material.dart';
import 'package:parent_wish/ui/screens/index.dart';

class AppRouter {
  static const String register = '/register';
  static const String splash = '/splash';
  static const String addChildren = '/add_children';
  static const String listChildren = '/list_children';
  static const String loginScreen = '/login';
  static const String completeProfile = '/complete_profile';
  static const String verificationEmail = '/verification_email';

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
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      default:
        return null;
    }
  }
}
