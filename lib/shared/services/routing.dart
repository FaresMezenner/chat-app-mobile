import 'package:chat_app/core/constants/routes.dart';
import 'package:chat_app/features/authentication/login_screen.dart';
import 'package:chat_app/features/authentication/register_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      // case '/':
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
      // case '/login':
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      // case '/profile':
      //   return MaterialPageRoute(builder: (_) => ProfileScreen());
      // default:
      //   return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
