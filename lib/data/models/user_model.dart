import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? uid,
    final String? name,
    final String? username,
    final String? email,
    final String? profilePhotoUrl,
  }) : super(
          uid: uid,
          name: name,
          username: username,
          email: email,
          profilePhotoUrl: profilePhotoUrl,
          password: '',
        );

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot['uid'],
      name: snapshot['name'],
      username: snapshot['username'],
      email: snapshot['email'],
      profilePhotoUrl: snapshot['profilePhotoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "username": username,
        "email": email,
        "profilePhotoUrl": profilePhotoUrl,
      };
}
