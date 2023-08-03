import 'package:flutter/material.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/injection_container.dart' as di;
import 'package:tokmat/presentation/cubit/cart_cubit.dart';

import '../../../core/utils.dart';

class ProductTileWidget extends StatefulWidget {
  final ProductEntity product;
  const ProductTileWidget({super.key, required this.product});

  @override
  State<ProductTileWidget> createState() => _ProductTileWidgetState();
}

class _ProductTileWidgetState extends State<ProductTileWidget> {
  bool _checkboxValue = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: double.infinity,
        child: Row(
          children: [
            const Spacer(flex: 1),
            const Placeholder(fallbackHeight: 50, fallbackWidth: 50),
            const Spacer(flex: 1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.product.name}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Text(formatPrice(widget.product.price)),
                const SizedBox(width: 10),
                Text("${widget.product.stock} items"),
                const SizedBox(width: 10),
              ],
            ),
            const Spacer(flex: 10),
            Checkbox(
              value: di.sl<CartCubit>().productExist(widget.product),
              onChanged: (value) {
                setState(() {
                  _checkboxValue = value!;
                });
                value!
                    ? di.sl<CartCubit>().addCart(widget.product)
                    : di.sl<CartCubit>().removeCart(widget.product);
              },
            )
          ],
        ),
      ),
    );
  }
}
