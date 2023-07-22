import 'package:tokmat/domain/repositories/firebase_repository.dart';

import '../../entities/transaction_entity.dart';

class GetTransactionUseCase {
  final FirebaseRepository repository;

  GetTransactionUseCase({required this.repository});

  Stream<List<TransactionEntity>> getTransactions() {
    return repository.getTransactions();
  }
}
