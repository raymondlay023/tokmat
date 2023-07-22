import '../../../domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  // Firebase User Features
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<String> getCurrentUid();
  Future<void> signOut();
  Stream<List<UserEntity>> getUser(String uid);

  // Firestore User Features
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
}
