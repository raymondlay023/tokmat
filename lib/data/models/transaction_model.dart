import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokmat/domain/entities/cart_entity.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

import 'cart_model.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    final String? id,
    final String? shopId,
    final String? note,
    final double? total,
    final String? type,
    final List<CartEntity>? items,
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
              .map((item) => CartModel.fromJson(item))
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
                return CartModel(
                  id: item.id,
                  product: item.product,
                  quantity: item.quantity,
                ).toJson();
              }).toList()
            : List.empty(),
        "created_at": createdAt,
      };
}
