import 'package:tokmat/domain/repositories/firebase_repository.dart';

class DeleteProductUseCase {
  final FirebaseRepository repository;

  DeleteProductUseCase({required this.repository});

  Future<void> call(String productId) {
    return repository.deleteProduct(productId);
  }
}
