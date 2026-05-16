import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyph_app/models/user_model.dart';
import 'package:handyph_app/models/user_role.dart';

/// HandyPH — Firebase Auth & Firestore Service Layer
///
/// Isolates all Firebase logic from UI code.
/// Handles authentication and user document CRUD.
///
/// Firestore schema:
///   users/{uid} → UserModel fields
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ════════════════════════════════════════════════════════════
  // AUTH STATE
  // ════════════════════════════════════════════════════════════

  /// Current Firebase Auth user (null if not logged in).
  User? get currentUser => _auth.currentUser;

  /// Stream that emits when auth state changes (login/logout).
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ════════════════════════════════════════════════════════════
  // REGISTRATION
  // ════════════════════════════════════════════════════════════

  /// Registers a homeowner: creates Firebase Auth account + Firestore profile.
  ///
  /// Returns the created [UserModel] on success.
  /// Throws [FirebaseAuthException] on failure.
  Future<UserModel> signUpHomeowner({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String location,
  }) async {
    // Step 1 — Create Firebase Auth account
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final uid = credential.user!.uid;

    // Step 2 — Build user model
    final userModel = UserModel(
      uid: uid,
      name: name.trim(),
      email: email.trim(),
      role: UserRole.homeowner,
      phone: phone.trim(),
      location: location.trim(),
      isVerified: false,
      createdAt: DateTime.now(),
    );

    // Step 3 — Save to Firestore
    await _firestore.collection('users').doc(uid).set(userModel.toMap());

    return userModel;
  }

  /// Registers a worker: creates Firebase Auth account + Firestore profile.
  ///
  /// Called on Step 1 of worker registration to create the auth account
  /// immediately. Firestore doc is created with all profile data.
  Future<UserModel> signUpWorker({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String primarySkill,
    required int yearsExperience,
    required int baseRate,
    String location = '',
  }) async {
    // Step 1 — Create Firebase Auth account
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final uid = credential.user!.uid;

    // Step 2 — Build user model with worker-specific fields
    final userModel = UserModel(
      uid: uid,
      name: name.trim(),
      email: email.trim(),
      role: UserRole.worker,
      phone: phone.trim(),
      location: location.trim(),
      isVerified: false,
      createdAt: DateTime.now(),
      primarySkill: primarySkill,
      yearsExperience: yearsExperience,
      baseRate: baseRate,
    );

    // Step 3 — Save to Firestore
    await _firestore.collection('users').doc(uid).set(userModel.toMap());

    return userModel;
  }

  // ════════════════════════════════════════════════════════════
  // LOGIN / LOGOUT
  // ════════════════════════════════════════════════════════════

  /// Signs in with email + password, then fetches the Firestore user document.
  ///
  /// Returns [UserModel] on success.
  /// Throws [FirebaseAuthException] on invalid credentials.
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final uid = credential.user!.uid;
    return await getUserModel(uid);
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ════════════════════════════════════════════════════════════
  // USER DATA
  // ════════════════════════════════════════════════════════════

  /// Fetches the [UserModel] from Firestore for a given [uid].
  ///
  /// Throws if the document doesn't exist.
  Future<UserModel> getUserModel(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();

    if (!doc.exists) {
      throw Exception('User document not found for uid: $uid');
    }

    return UserModel.fromFirestore(doc);
  }

  /// Updates specific fields on the user's Firestore document.
  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }
}
