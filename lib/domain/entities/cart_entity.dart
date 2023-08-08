import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/product_entity.dart';

class CartEntity extends Equatable {
  int id;
  ProductEntity product;
  int quantity;

  CartEntity({
    required this.id,
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, product, quantity];
}
