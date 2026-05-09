import 'package:go_router/go_router.dart';

// Feature screens
import 'package:handyph_app/features/auth/screens/role_selection_screen.dart';
import 'package:handyph_app/features/auth/screens/login_screen.dart';
import 'package:handyph_app/features/auth/screens/homeowner_registration_screen.dart';
import 'package:handyph_app/features/home/screens/home_screen.dart';
import 'package:handyph_app/features/discovery/screens/discovery_screen.dart';
import 'package:handyph_app/features/discovery/screens/worker_profile_screen.dart';
import 'package:handyph_app/features/booking/screens/booking_screen.dart';
import 'package:handyph_app/features/booking/screens/booking_confirmation_screen.dart';
import 'package:handyph_app/features/jobs/screens/my_jobs_screen.dart';
import 'package:handyph_app/features/jobs/screens/job_details_screen.dart';
import 'package:handyph_app/features/chat/screens/chat_screen.dart';
import 'package:handyph_app/features/profile/screens/profile_screen.dart';
import 'package:handyph_app/features/review/screens/review_service_screen.dart';
import 'package:handyph_app/features/worker_registration/screens/worker_registration_screen.dart';
import 'package:handyph_app/features/worker_registration/screens/worker_verification_screen.dart';
import 'package:handyph_app/features/worker_dashboard/screens/worker_dashboard_screen.dart';
import 'package:handyph_app/features/worker_dashboard/screens/worker_coming_soon_screen.dart';
import 'package:handyph_app/features/worker_dashboard/screens/worker_job_details_screen.dart';
import 'package:handyph_app/features/worker_dashboard/screens/worker_chat_screen.dart';

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

      // ── Worker Profile (Homeowner view) ─────────────
      GoRoute(
        path: '/view-worker-profile',
        name: 'view-worker-profile',
        builder: (context, state) => const WorkerProfileScreen(),
      ),

      // ── Booking ───────────────────────────────────────
      GoRoute(
        path: '/booking',
        name: 'booking',
        builder: (context, state) => const BookingScreen(),
      ),
      GoRoute(
        path: '/booking-confirmation',
        name: 'booking-confirmation',
        builder: (context, state) => const BookingConfirmationScreen(),
      ),

      // ── My Jobs ───────────────────────────────────────
      GoRoute(
        path: '/my-jobs',
        name: 'my-jobs',
        builder: (context, state) => const MyJobsScreen(),
      ),
      GoRoute(
        path: '/job-details',
        name: 'job-details',
        builder: (context, state) => const JobDetailsScreen(),
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
      GoRoute(
        path: '/review-service',
        name: 'review-service',
        builder: (context, state) => const ReviewServiceScreen(),
      ),

      // ── Worker Registration ────────────────────────────
      GoRoute(
        path: '/register-worker',
        name: 'register-worker',
        builder: (context, state) => const WorkerRegistrationScreen(),
      ),
      GoRoute(
        path: '/register-worker-verification',
        name: 'register-worker-verification',
        builder: (context, state) => const WorkerVerificationScreen(),
      ),
      GoRoute(
        path: '/worker-dashboard',
        name: 'worker-dashboard',
        builder: (context, state) => const WorkerDashboardScreen(),
      ),
      GoRoute(
        path: '/worker-job-details',
        name: 'worker-job-details',
        builder: (context, state) => const WorkerJobDetailsScreen(),
      ),
      GoRoute(
        path: '/worker-chat',
        name: 'worker-chat',
        builder: (context, state) => const WorkerChatScreen(),
      ),
      GoRoute(
        path: '/worker-home',
        name: 'worker-home',
        builder: (context, state) => const WorkerComingSoonScreen(
          tabName: 'Home',
          navIndex: 0,
        ),
      ),
      GoRoute(
        path: '/worker-discovery',
        name: 'worker-discovery',
        builder: (context, state) => const WorkerComingSoonScreen(
          tabName: 'Discovery',
          navIndex: 2,
        ),
      ),
      GoRoute(
        path: '/worker-profile',
        name: 'worker-profile',
        builder: (context, state) => const WorkerComingSoonScreen(
          tabName: 'Profile',
          navIndex: 3,
        ),
      ),
    ],
  );
}
