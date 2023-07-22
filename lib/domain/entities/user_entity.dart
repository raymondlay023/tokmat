import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? username;
  final String? email;
  final String? profilePhotoUrl;

  // not stored to database
  final String? password;

  const UserEntity({
    this.uid,
    this.name,
    this.username,
    this.email,
    this.profilePhotoUrl,
    this.password,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        username,
        email,
        profilePhotoUrl,
      ];
}
