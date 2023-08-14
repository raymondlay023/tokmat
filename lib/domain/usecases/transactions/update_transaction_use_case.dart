import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class UpdateTransactionUseCase {
  final FirebaseRepository repository;

  UpdateTransactionUseCase({required this.repository});

  Future<void> call(TransactionEntity transaction) {
    return repository.updateTransaction(transaction);
  }
}
