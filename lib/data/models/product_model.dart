import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokmat/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    final String? id,
    final String? shopId,
    final String? name,
    final double? price,
    final int? stock,
    final double? capital,
    final String? productPhotoUrl,
    final Timestamp? createdAt,
  }) : super(
          id: id,
          shopId: shopId,
          name: name,
          price: price,
          stock: stock,
          capital: capital,
          productPhotoUrl: productPhotoUrl,
          createdAt: createdAt,
        );

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ProductModel(
      id: snapshot['id'],
      shopId: snapshot['shop_id'],
      name: snapshot['name'],
      price: snapshot['price'],
      stock: snapshot['stock'],
      capital: snapshot['capital'],
      productPhotoUrl: snapshot['product_photo_url'],
      createdAt: snapshot['created_at'],
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      shopId: json['shop_id'],
      name: json['name'],
      price: json['price'],
      stock: json['stock'],
      capital: json['capital'],
      productPhotoUrl: json['product_photo_url'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "name": name,
        "price": price,
        "stock": stock,
        "capital": capital,
        "product_photo_url": productPhotoUrl,
        "created_at": createdAt,
      };
}
