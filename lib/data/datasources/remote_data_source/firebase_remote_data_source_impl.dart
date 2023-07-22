import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/data/models/user_model.dart';

import '../../../core/utils.dart';
import '../../../domain/entities/user_entity.dart';
import 'firebase_remote_data_source.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<void> signInUser(UserEntity user) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          {
            toast("User not found!");
          }
        case ("wrong-password"):
          {
            toast("Wrong password!");
          }

        default:
          toast("Something went wrong!");
      }
    }
  }

  @override
  Future<void> signUpUser(UserEntity user) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!)
          .then((userCredential) async {
        if (userCredential.user?.uid != null) {
          createUser(user);
        } else {
          toast("Sign up failed!");
        }
      });
    } on FirebaseAuthException catch (e) {
      toast(e.message ?? "Something went wrong!");
      switch (e.code) {
        case ("weak-password"):
          {
            toast("The password is too weak!");
          }
        case ("email-already-in-use"):
          {
            toast("The account already exists with that email!");
          }
        default:
          toast("Something went wrong!");
      }
    }
  }

  @override
  Future<void> signOut() async => await firebaseAuth.signOut();

  @override
  Future<bool> isSignIn() async => firebaseAuth.currentUser?.uid != null;

  @override
  Future<String> getCurrentUid() async => firebaseAuth.currentUser!.uid;

  @override
  Future<void> createUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final uid = await getCurrentUid();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        uid: uid,
        username: user.username ?? "",
        email: user.email ?? "",
        name: user.name ?? "",
        profilePhotoUrl: user.profilePhotoUrl ?? "",
      ).toJson();

      userDoc.exists
          ? userCollection.doc(uid).update(newUser)
          : userCollection.doc(uid).set(newUser);
    }).catchError((error) {
      toast("Some error occured!");
    });
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userCollection = firebaseFirestore.collection(FirebaseConst.users);
    final userUpdate = UserModel(
      username: user.username ?? "",
      email: user.email ?? "",
      name: user.name ?? "",
      profilePhotoUrl: user.profilePhotoUrl ?? "",
    ).toJson();

    userUpdate.removeWhere((key, value) => value == null || value == '');

    await userCollection.doc(user.uid).update(userUpdate);
  }

  @override
  Stream<List<UserEntity>> getUser(String uid) {
    final userCollection = firebaseFirestore
        .collection(FirebaseConst.users)
        .where("uid", isEqualTo: uid)
        .limit(1);
    return userCollection
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) {
              final data = UserModel.fromSnapshot(doc);
              print("user data : $data");
              return data;
            }).toList());
  }
}
