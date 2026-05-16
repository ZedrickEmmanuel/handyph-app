/// HandyPH — Centralized Route Constants
///
/// Single source of truth for all route paths.
/// Eliminates magic strings and prevents typo-related navigation bugs.
///
/// Usage:
///   context.push(AppRoutes.booking);
///   context.go(AppRoutes.home);
class AppRoutes {
  AppRoutes._();

  // ── Auth ──────────────────────────────────────────────
  static const roleSelection = '/role-selection';
  static const login = '/login';
  static const registerHomeowner = '/register-homeowner';

  // ── Homeowner ─────────────────────────────────────────
  static const home = '/home';
  static const discovery = '/discovery';
  static const viewWorkerProfile = '/view-worker-profile';
  static const booking = '/booking';
  static const bookingConfirmation = '/booking-confirmation';
  static const myJobs = '/my-jobs';
  static const jobDetails = '/job-details';
  static const chat = '/chat';
  static const profile = '/profile';
  static const reviewService = '/review-service';

  // ── Worker Registration ───────────────────────────────
  static const registerWorker = '/register-worker';
  static const registerWorkerVerification = '/register-worker-verification';

  // ── Worker Dashboard ──────────────────────────────────
  static const workerDashboard = '/worker-dashboard';
  static const workerJobDetails = '/worker-job-details';
  static const workerChat = '/worker-chat';
  static const workerHome = '/worker-home';
  static const workerDiscovery = '/worker-discovery';
  static const workerProfile = '/worker-profile';
}
