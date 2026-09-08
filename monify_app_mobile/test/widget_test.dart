// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:monify_app_mobile/main.dart';
import 'package:monify_app_mobile/screens/auth/Login.dart';
import 'package:monify_app_mobile/screens/home.dart';

void main() {
  testWidgets('la aplicación inicia en la pantalla de acceso', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Monify'), findsOneWidget);
    expect(find.text('¡Bienvenido a Monify!'), findsOneWidget);
  });

  testWidgets('la bienvenida mantiene un margen superior', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(tester.getTopLeft(find.text('Monify')).dy, greaterThanOrEqualTo(60));
  });

  testWidgets('el formulario aparece antes de cargar la animación Rive', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    await tester.tap(find.text('Iniciar sesión'));
    await tester.pump();

    expect(find.text('Hola de nuevo'), findsOneWidget);
    expect(find.byKey(const ValueKey('coin-rive-animation')), findsOneWidget);
  });

  testWidgets('el encabezado de inicio respeta el área superior segura', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(
          size: Size(390, 844),
          padding: EdgeInsets.only(top: 24),
        ),
        child: const MaterialApp(
          home: Scaffold(body: HomePage(userName: 'Ana')),
        ),
      ),
    );

    expect(
      tester.getTopLeft(find.text('Hola Ana')).dy,
      greaterThanOrEqualTo(40),
    );
  });
}
