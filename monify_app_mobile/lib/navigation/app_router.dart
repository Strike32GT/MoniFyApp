import 'package:flutter/material.dart';
import 'package:monify_app_mobile/navigation/app_routes.dart';
import 'package:monify_app_mobile/screens/Loading.dart';
import 'package:monify_app_mobile/screens/auth/CreateAccount.dart';
import 'package:monify_app_mobile/screens/auth/Login.dart';
import 'package:monify_app_mobile/screens/home.dart';
import 'package:monify_app_mobile/screens/perfil.dart';
import 'package:monify_app_mobile/screens/widgets/Configuration.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      case AppRoutes.createAccount:
        return MaterialPageRoute(
          builder: (_) => const CreateAccount(),
          settings: settings,
        );

      case AppRoutes.loading:
        final args = settings.arguments as Map<String, dynamic>?;

        return MaterialPageRoute(
          builder: (_) => LoadingScreen(
            userName: args?['userName']?.toString() ?? 'Usuario',
            userEmail: args?['userEmail']?.toString() ?? '',
          ),
          settings: settings,
        );

      case AppRoutes.home:
        final args = settings.arguments as Map<String, dynamic>?;

        return MaterialPageRoute(
          builder: (_) => Home(
            userName: args?['userName']?.toString() ?? 'Usuario',
            userEmail: args?['userEmail']?.toString() ?? '',
          ),
          settings: settings,
        );

      case AppRoutes.profile:
        final args = settings.arguments as Map<String, dynamic>?;

        return MaterialPageRoute(
          builder: (_) => ProfilePage(
            userName: args?['userName']?.toString() ?? 'Usuario',
            userEmail: args?['userEmail']?.toString() ?? '',
          ),
          settings: settings,
        );

      case AppRoutes.configuration:
        final args = settings.arguments as Map<String, dynamic>?;

        return MaterialPageRoute(
          builder: (_) => ConfigurationPage(
            userName: args?['userName']?.toString() ?? 'Usuario',
            userEmail: args?['userEmail']?.toString() ?? '',
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Ruta no encontrada'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
