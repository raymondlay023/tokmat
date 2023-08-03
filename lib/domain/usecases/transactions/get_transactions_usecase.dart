import 'package:tokmat/domain/entities/transaction_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class GetTransactionsUseCase {
  final FirebaseRepository repository;

  GetTransactionsUseCase({required this.repository});

  Stream<List<TransactionEntity>> call() {
    return repository.getTransactions();
  }
}
