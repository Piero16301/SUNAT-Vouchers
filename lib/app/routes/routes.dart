import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:sunat_vouchers/home/home.dart';
import 'package:sunat_vouchers/login/login.dart';
import 'package:sunat_vouchers/profile/profile.dart';

GoRouter goRouter() {
  const unauthenticatedRoutes = <String>{
    '/login',
  };

  return GoRouter(
    redirect: (context, state) {
      if (FirebaseAuth.instance.currentUser != null) {
        return state.location == '/login' ? '/' : null;
      } else {
        if (unauthenticatedRoutes.any(
          (value) {
            if (state.location != '/') return state.location.contains(value);
            return false;
          },
        )) {
          return null;
        } else {
          return '/login';
        }
      }
    },
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: 'profile',
            path: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );
}
