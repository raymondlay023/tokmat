import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class UpdateProductUseCase {
  final FirebaseRepository repository;

  UpdateProductUseCase({required this.repository});

  Future<void> call(ProductEntity product) {
    return repository.updateProduct(product);
  }
}
