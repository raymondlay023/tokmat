import '../entities/transaction_entity.dart';
import '../entities/user_entity.dart';

abstract class FirebaseRepository {
  // Firebase User Features
  Future<void> signInUser(UserEntity user);
  Future<void> signUpUser(UserEntity user);
  Future<bool> isSignIn();
  Future<String> getCurrentUid();
  Future<void> signOut();

  // Firestore User features
  Future<void> createUser(UserEntity user);
  Future<void> updateUser(UserEntity user);
  Stream<List<UserEntity>> getUser(String uid);

  // Transaction Features
  Stream<List<TransactionEntity>> getTransactions();
  Future<void> createTransaction(TransactionEntity transaction);
  Future<void> deleteTransaction(TransactionEntity transaction);
  Future<void> updateTransaction(TransactionEntity transaction);

  //! Cloud Storage Features
  // Future<String> uploadImageToStorage(File? file);
}
