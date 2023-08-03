import 'package:tokmat/domain/entities/transaction_entity.dart';

import '../../repositories/firebase_repository.dart';

class CreateTransactionUseCase {
  final FirebaseRepository repository;

  CreateTransactionUseCase({required this.repository});

  Future<void> call(TransactionEntity transactionEntity) {
    return repository.createTransaction(transactionEntity);
  }
}
