import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class CreateShopUseCase {
  final FirebaseRepository repository;

  CreateShopUseCase({required this.repository});

  Future<void> call(ShopEntity shop) {
    return repository.createShop(shop);
  }
}
