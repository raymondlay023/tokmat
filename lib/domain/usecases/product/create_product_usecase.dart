import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class CreateProductUseCase {
  final FirebaseRepository repository;

  CreateProductUseCase({required this.repository});

  Future<void> call(ProductEntity product) {
    return repository.createProduct(product);
  }
}
