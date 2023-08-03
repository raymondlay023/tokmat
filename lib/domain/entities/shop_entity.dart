import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ShopEntity extends Equatable {
  final String? id;
  final String? userId;
  final String? name;
  final String? phoneNumber;
  final String? category;
  final Timestamp? createdAt;

  const ShopEntity({
    this.id,
    this.userId,
    this.name,
    this.phoneNumber,
    this.category,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        phoneNumber,
        category,
      ];
}
