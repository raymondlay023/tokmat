import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/cart_entity.dart';

class TransactionEntity extends Equatable {
  final String? id;
  final String? shopId;
  final String? note;
  final double? total;
  final String? type;
  final List<CartEntity>? items;
  final Timestamp? createdAt;

  const TransactionEntity({
    this.id,
    this.shopId,
    this.note,
    this.total,
    this.type,
    this.items,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        shopId,
        note,
        total,
        type,
        items,
        createdAt,
      ];
}
