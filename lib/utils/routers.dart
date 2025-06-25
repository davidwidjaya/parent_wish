import 'package:flutter/material.dart';
import 'package:parent_wish/ui/screens/index.dart';

class AppRouter {
  static const String register = '/register';
  static const String splash = '/splash';

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
      default:
        return null;
    }
  }
}
