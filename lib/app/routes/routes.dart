import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:sunat_vouchers/edit_voucher/edit_voucher.dart';
import 'package:sunat_vouchers/home/home.dart';
import 'package:sunat_vouchers/login/login.dart';
import 'package:sunat_vouchers/new_voucher/new_voucher.dart';
import 'package:sunat_vouchers/profile/profile.dart';

GoRouter goRouter() {
  const unauthenticatedRoutes = <String>{
    '/login',
  };

  return GoRouter(
    redirect: (context, state) {
      if (FirebaseAuth.instance.currentUser != null) {
        return state.uri.toString() == '/login' ? '/' : null;
      } else {
        if (unauthenticatedRoutes.any(
          (value) {
            if (state.uri.toString() != '/') {
              return state.uri.toString().contains(value);
            }
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
          GoRoute(
            name: 'newVoucher',
            path: 'newVoucher/:userId',
            builder: (context, state) {
              final userId = state.pathParameters['userId']!;
              return NewVoucherPage(userId: userId);
            },
          ),
          GoRoute(
            name: 'editVoucher',
            path: 'editVoucher/:userId/:voucherId',
            builder: (context, state) {
              final userId = state.pathParameters['userId']!;
              final voucherId = state.pathParameters['voucherId']!;
              return EditVoucherPage(userUid: userId, voucherId: voucherId);
            },
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
  );
}
