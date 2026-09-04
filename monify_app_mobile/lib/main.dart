import 'package:flutter/material.dart';
import 'package:monify_app_mobile/navigation/app_router.dart';
import 'package:monify_app_mobile/navigation/app_routes.dart';
import 'package:monify_app_mobile/themes/normal_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monify App',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: NormalTheme.theme,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
