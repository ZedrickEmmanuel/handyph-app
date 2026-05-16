/// HandyPH — User Role Enum
///
/// Defines the two roles in the HandyPH ecosystem.
/// Used throughout auth, routing, and UI logic.
///
/// Usage:
///   role: UserRole.worker.name  → stores "worker" in Firestore
///   UserRole.values.byName(doc['role'])  → parses from Firestore
enum UserRole {
  homeowner,
  worker,
}
