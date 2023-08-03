part of 'cart_cubit.dart';

enum CartStatus { initial, loading, loaded, error, added, removed, updated }

class CartState extends Equatable {
  final List<CartEntity> cartList;
  final CartStatus status;

  const CartState({
    required this.cartList,
    required this.status,
  });

  factory CartState.initial() =>
      CartState(cartList: List.empty(), status: CartStatus.initial);

  CartState copyWith({List<CartEntity>? cartList, CartStatus? status}) {
    return CartState(
      cartList: cartList ?? this.cartList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [cartList, status];
}
