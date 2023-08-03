import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class UpdateShopUseCase {
  final FirebaseRepository repository;

  UpdateShopUseCase({required this.repository});

  Future<void> call(ShopEntity shop) {
    return repository.updateShop(shop);
  }
}
