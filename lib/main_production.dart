import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:sunat_vouchers/app/app.dart';
import 'package:sunat_vouchers/bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseUIAuth.configureProviders(
    [
      GoogleProvider(
        clientId: '1058631573511-tqbvjsscmvouras5t9oumm0rsub3oeil.apps.googleus'
            'ercontent.com',
        redirectUri: 'https://sunat-vouchers.firebaseapp.com/__/auth/handler',
      ),
    ],
  );

  final router = goRouter();

  await bootstrap(
    () => App(
      router: router,
    ),
  );
}
