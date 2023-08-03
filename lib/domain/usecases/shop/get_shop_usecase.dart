import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/domain/repositories/firebase_repository.dart';

class GetShopUseCase {
  final FirebaseRepository repository;

  GetShopUseCase({required this.repository});

  Future<ShopEntity> call() {
    return repository.getShop();
  }
}
