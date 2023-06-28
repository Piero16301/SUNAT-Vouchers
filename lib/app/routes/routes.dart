import 'package:go_router/go_router.dart';
import 'package:sunat_vouchers/login/login.dart';

GoRouter goRouter() {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
    debugLogDiagnostics: true,
  );
}
