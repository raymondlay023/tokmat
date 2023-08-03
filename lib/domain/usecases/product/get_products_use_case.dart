import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class GetProductsUseCase {
  final FirebaseRepository repository;

  GetProductsUseCase({required this.repository});

  Future<Stream<List<ProductEntity>>> call() {
    return repository.getProducts();
  }
}
