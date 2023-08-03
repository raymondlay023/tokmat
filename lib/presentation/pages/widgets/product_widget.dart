import 'package:flutter/material.dart';
import 'package:tokmat/domain/entities/product_entity.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(child: Text("${product.name}"));
  }
}
