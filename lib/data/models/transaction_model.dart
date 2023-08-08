import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokmat/data/models/product_model.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    final String? id,
    final String? shopId,
    final String? note,
    final double? total,
    final String? type,
    final List<ProductEntity>? items,
    final Timestamp? createdAt,
  }) : super(
          id: id,
          shopId: shopId,
          note: note,
          total: total,
          type: type,
          items: items,
          createdAt: createdAt,
        );

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return TransactionModel(
      id: snapshot['id'],
      shopId: snapshot['shop_id'],
      note: snapshot['note'],
      total: snapshot['total'],
      type: snapshot['type'],
      items: snapshot['items'] != null
          ? (snapshot['items'] as List<dynamic>)
              .map((item) => ProductModel.fromJson(item))
              .toList()
          : List.empty(),
      createdAt: snapshot['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "note": note,
        "total": total,
        "type": type,
        "items": items != null
            ? items!.map((item) {
                return ProductModel(
                  id: item.id,
                  name: item.name,
                  capital: item.capital,
                  price: item.price,
                  createdAt: item.createdAt,
                  productPhotoUrl: item.productPhotoUrl,
                  shopId: item.shopId,
                  stock: item.stock,
                ).toJson();
              }).toList()
            : List.empty(),
        "created_at": createdAt,
      };
}
