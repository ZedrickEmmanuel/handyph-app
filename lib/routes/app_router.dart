import 'package:go_router/go_router.dart';

// Feature screens
import 'package:handyph_app/features/auth/screens/role_selection_screen.dart';
import 'package:handyph_app/features/auth/screens/login_screen.dart';
import 'package:handyph_app/features/auth/screens/homeowner_registration_screen.dart';
import 'package:handyph_app/features/home/screens/home_screen.dart';
import 'package:handyph_app/features/discovery/screens/discovery_screen.dart';
import 'package:handyph_app/features/discovery/screens/worker_profile_screen.dart';
import 'package:handyph_app/features/booking/screens/booking_screen.dart';
import 'package:handyph_app/features/jobs/screens/my_jobs_screen.dart';
import 'package:handyph_app/features/chat/screens/chat_screen.dart';
import 'package:handyph_app/features/profile/screens/profile_screen.dart';

/// HandyPH — Router Configuration
///
/// Defines all application routes using go_router.
/// Initial location is /role-selection (unauthenticated state).
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/role-selection',
    debugLogDiagnostics: true,
    routes: [
      // ── Auth ──────────────────────────────────────────
      GoRoute(
        path: '/role-selection',
        name: 'role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register-homeowner',
        name: 'register-homeowner',
        builder: (context, state) => const HomeownerRegistrationScreen(),
      ),

      // ── Home ──────────────────────────────────────────
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // ── Discovery ─────────────────────────────────────
      GoRoute(
        path: '/discovery',
        name: 'discovery',
        builder: (context, state) => const DiscoveryScreen(),
      ),

      // ── Worker Profile ────────────────────────────────
      GoRoute(
        path: '/worker-profile',
        name: 'worker-profile',
        builder: (context, state) => const WorkerProfileScreen(),
      ),

      // ── Booking ───────────────────────────────────────
      GoRoute(
        path: '/booking',
        name: 'booking',
        builder: (context, state) => const BookingScreen(),
      ),

      // ── My Jobs ───────────────────────────────────────
      GoRoute(
        path: '/my-jobs',
        name: 'my-jobs',
        builder: (context, state) => const MyJobsScreen(),
      ),

      // ── Chat ──────────────────────────────────────────
      GoRoute(
        path: '/chat',
        name: 'chat',
        builder: (context, state) => const ChatScreen(),
      ),

      // ── Profile ───────────────────────────────────────
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
    ],
  );
}
