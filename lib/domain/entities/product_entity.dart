import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? shopId;
  final String? name;
  final double? price;
  final int? stock;
  final double? capital;
  final Timestamp? createdAt;

  const ProductEntity({
    this.id,
    this.shopId,
    this.name,
    this.price,
    this.stock,
    this.capital,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        shopId,
        name,
        price,
        stock,
        capital,
        createdAt,
      ];
}
