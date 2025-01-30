import 'package:flutter/material.dart';
import 'package:sl_salt/pages/Datainput_page/datainputpage.dart';
import 'package:sl_salt/pages/home_page/homepage.dart';
import 'package:sl_salt/pages/landing_pages/splash_screen.dart';
import 'package:sl_salt/pages/login_page/loginpage.dart';
import 'package:sl_salt/pages/login_page/registerpage.dart';
import 'route_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteNames.data:
        return MaterialPageRoute(builder: (_) => const Datainputpage());
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
