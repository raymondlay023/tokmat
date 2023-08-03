import 'package:tokmat/domain/entities/product_entity.dart';

class CartEntity {
  int id;
  ProductEntity product;
  int amount;

  CartEntity({
    required this.id,
    required this.product,
    required this.amount,
  });
}
