import 'package:flutter/material.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/injection_container.dart' as di;
import 'package:tokmat/presentation/cubit/cart_cubit.dart';
import 'package:tokmat/presentation/pages/widgets/photo_widget.dart';

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
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          PageConst.editProductPage,
          arguments: widget.product,
        ),
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            width: double.infinity,
            child: Row(
              children: [
                const Spacer(flex: 1),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: photoWidget(
                    defaultImage: 'assets/default-product-picture.png',
                    imageUrl: widget.product.productPhotoUrl,
                  ),
                ),
                const Spacer(flex: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.product.name}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(formatCurrency(widget.product.price)),
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
        ),
      ),
    );
  }
}
