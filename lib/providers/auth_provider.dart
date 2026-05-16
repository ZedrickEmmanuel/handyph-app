import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:handyph_app/models/user_model.dart';
import 'package:handyph_app/models/user_role.dart';
import 'package:handyph_app/services/auth_service.dart';

/// HandyPH — Authentication State Provider
///
/// Wraps [AuthService] with reactive state management.
/// Exposes loading, error, and user state for the UI layer.
///
/// Listens to Firebase [authStateChanges] for session persistence.
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  // ════════════════════════════════════════════════════════════
  // STATE
  // ════════════════════════════════════════════════════════════

  UserModel? _userModel;
  bool _isLoading = false;
  String? _error;
  bool _initialized = false;

  /// The current authenticated user's profile data.
  UserModel? get userModel => _userModel;

  /// Whether an auth operation is in progress.
  bool get isLoading => _isLoading;

  /// Last error message (null if no error).
  String? get error => _error;

  /// Whether the provider has finished its initial auth check.
  bool get initialized => _initialized;

  /// Whether a user is currently logged in.
  bool get isLoggedIn => _userModel != null;

  /// The current user's role (null if not logged in).
  UserRole? get userRole => _userModel?.role;

  // ════════════════════════════════════════════════════════════
  // INITIALIZATION
  // ════════════════════════════════════════════════════════════

  /// Initialize the provider by checking current auth state.
  ///
  /// Call once at app startup. If a user is already signed in
  /// (session persistence), fetches their Firestore profile.
  Future<void> initialize() async {
    final currentUser = _authService.currentUser;

    if (currentUser != null) {
      try {
        _userModel = await _authService.getUserModel(currentUser.uid);
      } catch (e) {
        // User exists in Auth but not Firestore — sign out
        await _authService.signOut();
        _userModel = null;
      }
    }

    _initialized = true;
    notifyListeners();
  }

  // ════════════════════════════════════════════════════════════
  // REGISTRATION
  // ════════════════════════════════════════════════════════════

  /// Register a new homeowner account.
  Future<bool> registerHomeowner({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String location,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _userModel = await _authService.signUpHomeowner(
        name: name,
        email: email,
        password: password,
        phone: phone,
        location: location,
      );
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(_mapAuthError(e.code));
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Registration failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  /// Register a new worker account.
  ///
  /// Creates Firebase Auth account + Firestore profile immediately.
  Future<bool> registerWorker({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String primarySkill,
    required int yearsExperience,
    required int baseRate,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _userModel = await _authService.signUpWorker(
        name: name,
        email: email,
        password: password,
        phone: phone,
        primarySkill: primarySkill,
        yearsExperience: yearsExperience,
        baseRate: baseRate,
      );
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(_mapAuthError(e.code));
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Registration failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  // ════════════════════════════════════════════════════════════
  // LOGIN / LOGOUT
  // ════════════════════════════════════════════════════════════

  /// Sign in with email + password.
  ///
  /// Fetches Firestore user profile and updates state.
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _clearError();

    try {
      _userModel = await _authService.signIn(
        email: email,
        password: password,
      );
      _setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      _setError(_mapAuthError(e.code));
      _setLoading(false);
      return false;
    } catch (e) {
      _setError('Login failed. Please try again.');
      _setLoading(false);
      return false;
    }
  }

  /// Sign out and clear all user state.
  Future<void> logout() async {
    _setLoading(true);
    await _authService.signOut();
    _userModel = null;
    _setLoading(false);
  }

  // ════════════════════════════════════════════════════════════
  // HELPERS
  // ════════════════════════════════════════════════════════════

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  /// Maps Firebase Auth error codes to user-friendly messages.
  String _mapAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Try logging in.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-credential':
        return 'Invalid email or password. Please try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
