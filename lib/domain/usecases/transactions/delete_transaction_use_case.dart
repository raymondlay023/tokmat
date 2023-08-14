import 'package:tokmat/domain/repositories/firebase_repository.dart';

class DeleteTransactionUseCase {
  final FirebaseRepository repository;

  DeleteTransactionUseCase({required this.repository});

  Future<void> call(String transactionId) {
    return repository.deleteTransaction(transactionId);
  }
}
