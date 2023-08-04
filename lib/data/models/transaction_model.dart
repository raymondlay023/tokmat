import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokmat/domain/entities/cart_entity.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    final String? id,
    final String? shopId,
    final String? note,
    final double? total,
    final String? type,
    final List<CartEntity>? cartItems,
    final Timestamp? createdAt,
  }) : super(
          id: id,
          shopId: shopId,
          note: note,
          total: total,
          type: type,
          cartItems: cartItems,
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
      cartItems: snap.get("cart_items"),
      createdAt: snapshot['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "note": note,
        "total": total,
        "type": type,
        "created_at": createdAt,
      };
}
