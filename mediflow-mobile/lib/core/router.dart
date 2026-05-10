import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/agent/my_patients_screen.dart';
import '../screens/agent/upload_patient_screen.dart';
import '../screens/shared/pending_approval_screen.dart';
import '../screens/shared/deactivated_screen.dart';
import '../screens/head_doctor/hd_dashboard_screen.dart';
import '../screens/doctor/doctor_dashboard_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';

      if (authState.status == AuthStatus.authenticated) {
        final user = authState.user;

        // Handle Status First
        if (user?.status == 'pending') return '/pending-approval';
        if (user?.status == 'deactivated') return '/deactivated';

        // If trying to access login/register while active
        if (isLoggingIn || isRegistering || state.matchedLocation == '/pending-approval' || state.matchedLocation == '/deactivated') {
          if (user?.role == 'HEAD_DOCTOR') return '/head-doctor/dashboard';
          if (user?.role == 'DOCTOR') return '/doctor/dashboard';
          if (user?.role == 'AGENT') return '/agent/patients';
          return '/login';
        }
      }

      if (authState.status == AuthStatus.unauthenticated) {
        if (!isLoggingIn && !isRegistering) return '/login';
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
        builder: (context, state) {
          final token = state.uri.queryParameters['token'];
          return RegisterScreen(inviteToken: token);
        },
      ),
      GoRoute(
        path: '/pending-approval',
        builder: (context, state) => const PendingApprovalScreen(),
      ),
      GoRoute(
        path: '/deactivated',
        builder: (context, state) => const DeactivatedAccountScreen(),
      ),
      // Role Dashboards
      GoRoute(
        path: '/head-doctor/dashboard',
        builder: (context, state) => const HdDashboardScreen(),
      ),
      GoRoute(
        path: '/doctor/dashboard',
        builder: (context, state) => const DoctorDashboardScreen(),
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
