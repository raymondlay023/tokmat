import 'dart:io';

import '../entities/product_entity.dart';
import '../entities/shop_entity.dart';
import '../entities/transaction_entity.dart';
import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  // Firebase User Features
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<void> signOut();
  Future<String> getCurrentUid();

  // Firestore User features
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
  // Future<void> deleteTransaction(TransactionEntity transaction);
  // Future<void> updateTransaction(TransactionEntity transaction);

  // Product Features
  Future<Stream<List<ProductEntity>>> getProducts();
  Future<void> createProduct(ProductEntity product);
  // Future<void> updateProduct(ProductEntity product);
  // Future<void> deleteProduct(ProductEntity product);

  // Cloud Storage Features
  Future<String> uploadImageToStorage(
      File? file, String childName, bool isUserProfile);
}
