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

  @override
  String get signInMethods => 'Métodos de inicio de sesión';

  @override
  String get signOutButtonText => 'Cerrar sesión';

  @override
  String get deleteAccount => 'Eliminar cuenta';
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
        useMaterial3: true,
        primaryColor: const Color.fromRGBO(0, 97, 173, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(0, 97, 173, 1),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Ubuntu-Regular',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white, size: 30),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(0, 97, 173, 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            foregroundColor: const Color.fromRGBO(0, 97, 173, 1),
          ),
        ),
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
