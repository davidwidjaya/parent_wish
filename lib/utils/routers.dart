import 'package:flutter/material.dart';
import 'package:parent_wish/ui/screens/register_screen.dart';

class AppRouter {
  static const String home = '/home';

  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      default:
        return null;
    }
  }
}
