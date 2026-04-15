import 'package:flutter/material.dart';
import 'package:monify_app_mobile/navigation/app_router.dart';
import 'package:monify_app_mobile/navigation/app_routes.dart';
import 'package:monify_app_mobile/themes/dark_theme.dart';
import 'package:monify_app_mobile/themes/normal_theme.dart';
import 'package:monify_app_mobile/themes/theme_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController _themeController = ThemeController.instance;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeController,
      builder: (context, _) {
        return MaterialApp(
          title: 'Monify App',
          debugShowMaterialGrid: false,
          debugShowCheckedModeBanner: false,
          theme: NormalTheme.theme,
          darkTheme: DarkTheme.theme,
          themeMode: _themeController.themeMode,
          initialRoute: AppRoutes.login,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}

