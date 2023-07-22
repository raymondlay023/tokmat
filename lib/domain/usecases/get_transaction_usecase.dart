import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class GetTransactionUseCase {
  final FirebaseRepository repository;

  GetTransactionUseCase({required this.repository});

  Stream<List<TransactionEntity>> getTransactions() {
    return repository.getTransactions();
  }
}
