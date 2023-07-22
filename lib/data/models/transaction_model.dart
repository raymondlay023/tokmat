import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokmat/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  const TransactionModel({
    final String? id,
    final String? userId,
    final String? note,
    final double? total,
    final String? type,
  }) : super(
          id: id,
          userId: userId,
          note: note,
          total: total,
          type: type,
        );

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return TransactionModel(
      id: snapshot['id'],
      userId: snapshot['userId'],
      note: snapshot['note'],
      total: snapshot['total'],
      type: snapshot['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "note": note,
        "total": total,
        "type": type,
      };
}
