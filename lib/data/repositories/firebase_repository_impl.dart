import 'dart:io';

import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';
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
  Future<UserEntity> getUser() => firebaseRemoteDataSource.getUser();

  @override
  Future<void> createTransaction(TransactionEntity transaction) async =>
      await firebaseRemoteDataSource.createTransaction(transaction);

  @override
  Stream<List<TransactionEntity>> getTransactions() =>
      firebaseRemoteDataSource.getTransactions();

  @override
  Future<void> createShop(ShopEntity shop) async =>
      await firebaseRemoteDataSource.createShop(shop);

  @override
  Future<ShopEntity> getShop() async =>
      await firebaseRemoteDataSource.getShop();

  @override
  Future<void> updateShop(ShopEntity shop) async =>
      await firebaseRemoteDataSource.updateShop(shop);

  @override
  Future<void> createProduct(ProductEntity product) async =>
      await firebaseRemoteDataSource.createProduct(product);

  @override
  Future<Stream<List<ProductEntity>>> getProducts() async =>
      await firebaseRemoteDataSource.getProducts();

  @override
  Future<String> uploadImageToStorage(
          File? file, String childName, bool isUserProfile) async =>
      await firebaseRemoteDataSource.uploadImageToStorage(
          file, childName, isUserProfile);
}
