import 'dart:io';

import '../../../domain/entities/product_entity.dart';
import '../../../domain/entities/shop_entity.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/entities/user_entity.dart';

abstract class FirebaseRemoteDataSource {
  // Credential Features
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<void> signOut();
  Future<bool> isSignIn();
  Future<String> getCurrentUid();

  // User Features
  Future<UserEntity> getUser();
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);

  // Shop Features
  Future<ShopEntity> getShop();
  Future<void> createShop(ShopEntity shop);
  Future<void> updateShop(ShopEntity shop);

  // Transaction Features
  Stream<List<TransactionEntity>> getTransactions();
  Future<void> createTransaction(TransactionEntity transaction);

  // Product Features
  Future<Stream<List<ProductEntity>>> getProducts();
  Future<void> createProduct(ProductEntity product);

  // Cloud Storage Features
  Future<String> uploadImageToStorage(
      File? file, String childName, bool isUserProfile);
}
