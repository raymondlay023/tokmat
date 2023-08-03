import 'package:flutter/material.dart';
import 'package:tokmat/domain/entities/cart_entity.dart';
import 'package:tokmat/injection_container.dart' as di;
import '../../../core/utils.dart';
import '../../cubit/cart_cubit.dart';

class CartWidget extends StatelessWidget {
  final CartEntity cart;
  const CartWidget({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Text("${cart.quantity}x"),
            const Spacer(
              flex: 1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cart.product.name!),
                Text(formatPrice(di.sl<CartCubit>().getTotal(id: cart.id)))
              ],
            ),
            const Spacer(
              flex: 3,
            ),
            IconButton(
              onPressed: () => di.sl<CartCubit>().reduceQuantity(cart.id),
              icon: Icon(Icons.remove_circle_outline),
            ),
            Text("${cart.quantity}"),
            IconButton(
              onPressed: () => di.sl<CartCubit>().addQuantity(cart.id),
              icon: Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }
}
