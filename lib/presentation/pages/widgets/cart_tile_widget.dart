import 'package:flutter/material.dart';
import 'package:tokmat/domain/entities/cart_entity.dart';
import 'package:tokmat/injection_container.dart' as di;
import '../../../core/utils.dart';
import '../../cubit/cart_cubit.dart';

class CartTileWidget extends StatelessWidget {
  final CartEntity cart;
  const CartTileWidget({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 10,
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
                      Text(
                          formatPrice(di.sl<CartCubit>().getTotal(id: cart.id)))
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
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => di.sl<CartCubit>().removeCart(cart.product),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  color: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.delete,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
