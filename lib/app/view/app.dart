import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get registerText => 'Registrarse';

  @override
  String get registerHintText => '¿No tienes una cuenta?';

  @override
  String get signInText => 'Iniciar sesión';

  @override
  String get signInHintText => '¿Ya tienes una cuenta?';

  @override
  String get signInWithGoogleButtonText => 'Iniciar sesión con Google';
}

class App extends StatelessWidget {
  const App({
    required GoRouter router,
    super.key,
  }) : _router = router;

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: const TextStyle(fontFamily: 'Ubuntu-Regular'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
    );
  }
}
