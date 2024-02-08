import 'package:chat_app/core/constants/routes.dart';
import 'package:chat_app/features/authentication/login_screen.dart';
import 'package:chat_app/features/authentication/register_screen.dart';
import 'package:chat_app/features/profile/screens/profile_screen.dart';
import 'package:chat_app/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
