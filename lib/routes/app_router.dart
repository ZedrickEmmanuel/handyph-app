import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

// Route constants
import 'package:handyph_app/routes/app_routes.dart';

// Auth provider
import 'package:handyph_app/providers/auth_provider.dart';
import 'package:handyph_app/models/user_role.dart';

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
/// Includes auth-based redirect logic:
///   - Not logged in → /role-selection (except auth routes)
///   - Logged in homeowner → /home (if on auth route)
///   - Logged in worker → /worker-dashboard (if on auth route)
class AppRouter {
  AppRouter._();

  /// Auth routes that don't require authentication.
  static const _publicRoutes = [
    AppRoutes.roleSelection,
    AppRoutes.login,
    AppRoutes.registerHomeowner,
    AppRoutes.registerWorker,
    AppRoutes.registerWorkerVerification,
  ];

  static GoRouter router(AuthProvider authProvider) {
    return GoRouter(
      initialLocation: AppRoutes.roleSelection,
      debugLogDiagnostics: kDebugMode,
      refreshListenable: authProvider,
      redirect: (context, state) {
        final isLoggedIn = authProvider.isLoggedIn;
        final currentPath = state.matchedLocation;
        final isPublicRoute = _publicRoutes.contains(currentPath);

        // Not logged in → redirect to role selection (unless already on a public route)
        if (!isLoggedIn && !isPublicRoute) {
          return AppRoutes.roleSelection;
        }

        // Logged in but on an auth route → redirect to appropriate dashboard
        if (isLoggedIn && isPublicRoute) {
          if (authProvider.userRole == UserRole.worker) {
            return AppRoutes.workerDashboard;
          }
          return AppRoutes.home;
        }

        // No redirect needed
        return null;
      },
      routes: [
        // ── Auth ──────────────────────────────────────────
        GoRoute(
          path: AppRoutes.roleSelection,
          name: 'role-selection',
          builder: (context, state) => const RoleSelectionScreen(),
        ),
        GoRoute(
          path: AppRoutes.login,
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.registerHomeowner,
          name: 'register-homeowner',
          builder: (context, state) => const HomeownerRegistrationScreen(),
        ),

        // ── Home ──────────────────────────────────────────
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          builder: (context, state) => const HomeScreen(),
        ),

        // ── Discovery ─────────────────────────────────────
        GoRoute(
          path: AppRoutes.discovery,
          name: 'discovery',
          builder: (context, state) => const DiscoveryScreen(),
        ),

        // ── Worker Profile (Homeowner view) ─────────────
        GoRoute(
          path: AppRoutes.viewWorkerProfile,
          name: 'view-worker-profile',
          builder: (context, state) => const WorkerProfileScreen(),
        ),

        // ── Booking ───────────────────────────────────────
        GoRoute(
          path: AppRoutes.booking,
          name: 'booking',
          builder: (context, state) => const BookingScreen(),
        ),
        GoRoute(
          path: AppRoutes.bookingConfirmation,
          name: 'booking-confirmation',
          builder: (context, state) => const BookingConfirmationScreen(),
        ),

        // ── My Jobs ───────────────────────────────────────
        GoRoute(
          path: AppRoutes.myJobs,
          name: 'my-jobs',
          builder: (context, state) => const MyJobsScreen(),
        ),
        GoRoute(
          path: AppRoutes.jobDetails,
          name: 'job-details',
          builder: (context, state) => const JobDetailsScreen(),
        ),

        // ── Chat ──────────────────────────────────────────
        GoRoute(
          path: AppRoutes.chat,
          name: 'chat',
          builder: (context, state) => const ChatScreen(),
        ),

        // ── Profile ───────────────────────────────────────
        GoRoute(
          path: AppRoutes.profile,
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: AppRoutes.reviewService,
          name: 'review-service',
          builder: (context, state) => const ReviewServiceScreen(),
        ),

        // ── Worker Registration ────────────────────────────
        GoRoute(
          path: AppRoutes.registerWorker,
          name: 'register-worker',
          builder: (context, state) => const WorkerRegistrationScreen(),
        ),
        GoRoute(
          path: AppRoutes.registerWorkerVerification,
          name: 'register-worker-verification',
          builder: (context, state) => const WorkerVerificationScreen(),
        ),
        GoRoute(
          path: AppRoutes.workerDashboard,
          name: 'worker-dashboard',
          builder: (context, state) => const WorkerDashboardScreen(),
        ),
        GoRoute(
          path: AppRoutes.workerJobDetails,
          name: 'worker-job-details',
          builder: (context, state) => const WorkerJobDetailsScreen(),
        ),
        GoRoute(
          path: AppRoutes.workerChat,
          name: 'worker-chat',
          builder: (context, state) => const WorkerChatScreen(),
        ),
        GoRoute(
          path: AppRoutes.workerHome,
          name: 'worker-home',
          builder: (context, state) => const WorkerComingSoonScreen(
            tabName: 'Home',
            navIndex: 0,
          ),
        ),
        GoRoute(
          path: AppRoutes.workerDiscovery,
          name: 'worker-discovery',
          builder: (context, state) => const WorkerComingSoonScreen(
            tabName: 'Discovery',
            navIndex: 2,
          ),
        ),
        GoRoute(
          path: AppRoutes.workerProfile,
          name: 'worker-profile',
          builder: (context, state) => const WorkerComingSoonScreen(
            tabName: 'Profile',
            navIndex: 3,
          ),
        ),
      ],
    );
  }
}
