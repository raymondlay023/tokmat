import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokmat/data/models/product_model.dart';
import 'package:tokmat/domain/entities/cart_entity.dart';

import '../../domain/entities/product_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    required int id,
    required ProductEntity product,
    required int quantity,
  }) : super(
          id: id,
          product: product,
          quantity: quantity,
        );

  factory CartModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CartModel(
      id: snapshot['id'],
      product: snapshot['product'],
      quantity: snapshot['quantity'],
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": ProductModel(
          id: product.id,
          name: product.name,
          capital: product.capital,
          price: product.price,
          createdAt: product.createdAt,
          productPhotoUrl: product.productPhotoUrl,
          shopId: product.shopId,
          stock: product.stock,
        ).toJson(),
        "quantity": quantity,
      };
}
