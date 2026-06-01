import 'package:flutter/material.dart';
import '../../features/users/presentation/pages/login_page.dart';
import '../../features/users/presentation/pages/register_page.dart';
import '../../features/habits/presentation/screens/habits_screen.dart';

class AppRoutes {
  static const String login = '/';
  static const String register = '/register';
  static const String habits = '/habits';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case habits:
        return MaterialPageRoute(builder: (_) => const HabitsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
