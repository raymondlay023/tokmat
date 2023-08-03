import 'package:flutter/material.dart';
import 'package:tokmat/domain/entities/product_entity.dart';

class CartWidget extends StatelessWidget {
  final ProductEntity product;
  const CartWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              Text("1 x"),
              Text(product.name!),
              Text("Rp. 15.950,00"),
            ],
          )
        ],
      ),
    );
  }
}
