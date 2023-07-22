import 'package:tokmat/domain/entities/transaction_entity.dart';

import '../datasources/remote_data_source/firebase_remote_data_source.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<bool> isSignIn() async => await firebaseRemoteDataSource.isSignIn();

  @override
  Future<void> signInUser(UserEntity user) async =>
      await firebaseRemoteDataSource.signInUser(user);

  @override
  Future<void> signUpUser(UserEntity user) async =>
      await firebaseRemoteDataSource.signUpUser(user);

  @override
  Future<void> signOut() async => await firebaseRemoteDataSource.signOut();

  @override
  Future<String> getCurrentUid() async =>
      await firebaseRemoteDataSource.getCurrentUid();

  @override
  Future<void> createUser(UserEntity user) async =>
      await firebaseRemoteDataSource.createUser(user);

  @override
  Future<void> updateUser(UserEntity user) async =>
      await firebaseRemoteDataSource.updateUser(user);

  @override
  Stream<List<UserEntity>> getUser(String uid) =>
      firebaseRemoteDataSource.getUser(uid);

  @override
  Future<void> createTransaction(TransactionEntity transaction) {
    // TODO: implement createTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTransaction(TransactionEntity transaction) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Stream<List<TransactionEntity>> getTransactions() {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
