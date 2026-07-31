import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    required super.farmLocation,
    super.role = 'Farmer',
    super.isAnonymous = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      email: map['email'] as String? ?? '',
      fullName: map['fullName'] as String? ?? 'Farmer',
      farmLocation: map['farmLocation'] as String? ?? 'Musanze',
      role: map['role'] as String? ?? 'Farmer',
      isAnonymous: map['isAnonymous'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'farmLocation': farmLocation,
      'role': role,
      'isAnonymous': isAnonymous,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      fullName: entity.fullName,
      farmLocation: entity.farmLocation,
      role: entity.role,
      isAnonymous: entity.isAnonymous,
    );
  }
}
