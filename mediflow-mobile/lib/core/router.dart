import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/agent/my_patients_screen.dart';
import '../screens/agent/upload_patient_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      if (authState.status == AuthStatus.authenticated) {
        if (isLoggingIn || isRegistering) {
          // Redirect based on role
          if (authState.user?.role == 'AGENT') {
            return '/agent/patients';
          }
          // Default for now
          return '/agent/patients';
        }
      }

      if (authState.status == AuthStatus.unauthenticated) {
        if (!isLoggingIn && !isRegistering) {
          return '/login';
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      // Agent Routes
      GoRoute(
        path: '/agent/patients',
        builder: (context, state) => const MyPatientsScreen(),
      ),
      GoRoute(
        path: '/agent/upload-patient',
        builder: (context, state) => const UploadPatientScreen(),
      ),
    ],
  );
});
