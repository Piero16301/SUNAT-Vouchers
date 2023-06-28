import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75),
                child: Image.asset(
                  'assets/images/sunat_logo.png',
                ),
              ),
              const GoogleSignInButtonLogin(),
            ],
          ),
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
    return SizedBox(
      height: 241,
      child: SignInScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, signedIn) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Sesión iniciada con ${signedIn.user}'),
              ),
            );
          }),
          AuthStateChangeAction<UserCreated>((context, userCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Usuario creado ${userCreated.credential.user}'),
              ),
            );
          }),
          AuthStateChangeAction<AuthFailed>((context, error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error ${error.exception}'),
              ),
            );
          }),
        ],
      ),
    );
  }
}
