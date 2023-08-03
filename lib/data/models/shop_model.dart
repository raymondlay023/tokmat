import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';

class ShopModel extends ShopEntity {
  ShopModel({
    final String? id,
    final String? userId,
    final String? name,
    final String? phoneNumber,
    final String? category,
    final Timestamp? createdAt,
  }) : super(
          id: id,
          userId: userId,
          name: name,
          phoneNumber: phoneNumber,
          category: category,
          createdAt: createdAt,
        );

  factory ShopModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ShopModel(
        id: snapshot['id'],
        userId: snapshot['user_id'],
        name: snapshot['name'],
        phoneNumber: snapshot['phone_number'],
        category: snapshot['category'],
        createdAt: snapshot['created_at']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone_number": phoneNumber,
        "category": category,
        "created_at": createdAt,
      };
}
