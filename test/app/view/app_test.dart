// Ignore for testing purposes
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sunat_vouchers/app/app.dart';

void main() {
  group('App', () {
    testWidgets('renders App widget', (tester) async {
      // Create a simple test router
      final testRouter = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: Center(child: Text('Test Home')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(App(router: testRouter));
      expect(find.byType(App), findsOneWidget);
    });
  });
}
