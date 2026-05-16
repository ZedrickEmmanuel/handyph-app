import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handyph_app/models/user_role.dart';

/// HandyPH — User Data Model
///
/// Represents the app-specific user profile stored in Firestore `users/{uid}`.
/// Firebase Auth only stores email/uid — this model holds all app data.
///
/// Fields:
///   - Core: uid, name, email, role, phone, location
///   - Worker-specific: primarySkill, yearsExperience, baseRate
///   - Meta: isVerified, createdAt
class UserModel {
  final String uid;
  final String name;
  final String email;
  final UserRole role;
  final String phone;
  final String location;
  final bool isVerified;
  final DateTime createdAt;

  // Worker-specific fields (null for homeowners)
  final String? primarySkill;
  final int? yearsExperience;
  final int? baseRate;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.location,
    this.isVerified = false,
    required this.createdAt,
    this.primarySkill,
    this.yearsExperience,
    this.baseRate,
  });

  /// Whether this user is a worker.
  bool get isWorker => role == UserRole.worker;

  /// Whether this user is a homeowner.
  bool get isHomeowner => role == UserRole.homeowner;

  // ════════════════════════════════════════════════════════════
  // SERIALIZATION
  // ════════════════════════════════════════════════════════════

  /// Converts this model to a Firestore-compatible map.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'role': role.name,
      'phone': phone,
      'location': location,
      'isVerified': isVerified,
      'createdAt': Timestamp.fromDate(createdAt),
      if (primarySkill != null) 'primarySkill': primarySkill,
      if (yearsExperience != null) 'yearsExperience': yearsExperience,
      if (baseRate != null) 'baseRate': baseRate,
    };
  }

  /// Creates a [UserModel] from a Firestore document map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      role: UserRole.values.byName(map['role'] as String),
      phone: map['phone'] as String? ?? '',
      location: map['location'] as String? ?? '',
      isVerified: map['isVerified'] as bool? ?? false,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      primarySkill: map['primarySkill'] as String?,
      yearsExperience: map['yearsExperience'] as int?,
      baseRate: map['baseRate'] as int?,
    );
  }

  /// Creates a [UserModel] from a Firestore [DocumentSnapshot].
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  /// Creates a copy with modified fields.
  UserModel copyWith({
    String? name,
    String? phone,
    String? location,
    bool? isVerified,
    String? primarySkill,
    int? yearsExperience,
    int? baseRate,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      role: role,
      createdAt: createdAt,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      isVerified: isVerified ?? this.isVerified,
      primarySkill: primarySkill ?? this.primarySkill,
      yearsExperience: yearsExperience ?? this.yearsExperience,
      baseRate: baseRate ?? this.baseRate,
    );
  }
}
