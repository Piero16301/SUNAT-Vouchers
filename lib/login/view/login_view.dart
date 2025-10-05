import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 75),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    'assets/images/app_icon.png',
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Verificación de Comprobantes'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Ubuntu-Bold',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const GoogleSignInButtonLogin(),
            const SizedBox(height: 50),
            const Text(
              'Esta aplicación está hecha exclusivamente con fines académicos y'
              ' no debe ser utilizada como una fuente de información oficial. '
              'Por lo cual se renuncia a cualquier responsabilidad de uso '
              'indebido, ya que la aplicación no representa a ninguna entidad '
              'gubernamental.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'Ubuntu-Regular',
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class GoogleSignInButtonLogin extends StatelessWidget {
  const GoogleSignInButtonLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, signedIn) {
            debugPrint('User: ${signedIn.user}');

            // Guardar datos del usuario en Firestore
            unawaited(
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(signedIn.user!.uid)
                  .set({
                    'uid': signedIn.user!.uid,
                    'displayName': signedIn.user!.displayName,
                    'email': signedIn.user!.email,
                    'emailVerified': signedIn.user!.emailVerified,
                    'isAnonymous': signedIn.user!.isAnonymous,
                    'photoURL': signedIn.user!.photoURL,
                    'providerId': signedIn.user!.providerData[0].providerId,
                    'providerUid': signedIn.user!.providerData[0].uid,
                  }),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '¡Bienvenido! ${signedIn.user!.displayName}',
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 3),
              ),
            );

            context.pushReplacementNamed('home');
          }),
          AuthStateChangeAction<UserCreated>((context, signedUp) {
            debugPrint('User: ${signedUp.credential.user}');

            // Guardar datos del usuario en Firestore
            unawaited(
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(signedUp.credential.user!.uid)
                  .set({
                    'uid': signedUp.credential.user!.uid,
                    'displayName': signedUp.credential.user!.displayName,
                    'email': signedUp.credential.user!.email,
                    'emailVerified': signedUp.credential.user!.emailVerified,
                    'isAnonymous': signedUp.credential.user!.isAnonymous,
                    'photoURL': signedUp.credential.user!.photoURL,
                    'providerId':
                        signedUp.credential.user!.providerData[0].providerId,
                    'providerUid':
                        signedUp.credential.user!.providerData[0].uid,
                  }),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '¡Bienvenido! ${signedUp.credential.user!.displayName}',
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 3),
              ),
            );

            context.pushReplacementNamed('home');
          }),
          AuthStateChangeAction<AuthFailed>((context, error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error ${error.exception}',
                  textAlign: TextAlign.center,
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }),
        ],
      ),
    );
  }
}
