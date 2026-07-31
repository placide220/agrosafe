import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String fullName;
  final String farmLocation;
  final String role;
  final bool isAnonymous;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.farmLocation,
    this.role = 'Farmer',
    this.isAnonymous = false,
  });

  @override
  List<Object?> get props => [
    uid,
    email,
    fullName,
    farmLocation,
    role,
    isAnonymous,
  ];
}
