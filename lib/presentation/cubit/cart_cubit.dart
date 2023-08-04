import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/product_entity.dart';

import '../../domain/entities/cart_entity.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  final List<CartEntity> _carts = [];

  List<CartEntity> get cartList => state.cartList;

  void addCart(ProductEntity product) {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      if (!productExist(product)) {
        _carts.add(CartEntity(
          id: _carts.length,
          product: product,
          quantity: 1,
        ));
        emit(CartState(cartList: _carts, status: CartStatus.updated));
      }
    } catch (e) {
      print("addCart error : $e");
      emit(state.copyWith(status: CartStatus.failure));
    }

    // Debug
    print("addCart _carts : ${_carts.map((e) => e.product.name)}");
    print("cartList: $cartList");
  }

  void removeCart(ProductEntity product) {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      int index = _getIndexByProduct(product);
      if (productExist(product)) {
        _carts.removeAt(index);
        emit(state.copyWith(cartList: _carts, status: CartStatus.updated));
      }
    } catch (e) {
      print("removeCart error : $e");
      emit(state.copyWith(status: CartStatus.failure));
    }

    // Debug
    print("removeCart _carts : ${_carts.map((e) => e.product.name)}");
    print("cartList: $cartList");
  }

  void removeCartById(int id) {
    int index = _getIndexById(id);
    _carts.removeAt(index);
    emit(state.copyWith(cartList: _carts, status: CartStatus.updated));

    //Debug
    print("removeCartById _carts : ${_carts.map((e) => e.product.name)}");
    print("cartList: $cartList");
  }

  void addQuantity(int id) {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      int index = _getIndexById(id);
      if (index != -1) {
        _carts[index].quantity++;
        emit(state.copyWith(cartList: _carts, status: CartStatus.updated));
      }
    } catch (e) {
      print("addQuantity error : $e");
      emit(state.copyWith(status: CartStatus.failure));
    }

    // Debug
    print("addQuantity _carts : ${_carts.map((e) => e.quantity)}");
    print("cartList: $cartList");
  }

  void reduceQuantity(int id) {
    emit(state.copyWith(status: CartStatus.loading));

    try {
      int index = _getIndexById(id);
      if (index != -1) {
        if (_carts[index].quantity > 1) {
          _carts[index].quantity--;
          emit(state.copyWith(cartList: _carts, status: CartStatus.updated));
        } else {
          removeCartById(id);
          emit(state.copyWith(cartList: _carts, status: CartStatus.updated));
        }
      }
    } catch (e) {
      print("reduceQuantity error : $e");
      emit(state.copyWith(status: CartStatus.failure));
    }

    // Debug
    print("reduceQuantity _carts : ${_carts.map((e) => e.quantity)}");
    print("cartList: $cartList");
  }

  bool productExist(ProductEntity product) {
    if (_getIndexByProduct(product) != -1) {
      return true;
    } else {
      return false;
    }
  }

  double getTotal({int? id}) {
    if (id != null) {
      int index = _getIndexById(id);
      var cart = _carts[index];
      return cart.quantity * cart.product.price!;
    } else {
      return _carts.fold(
          0, (total, cart) => total + cart.quantity * cart.product.price!);
    }
  }

  int _getIndexById(int id) => _carts.indexWhere((cart) => cart.id == id);

  int _getIndexByProduct(ProductEntity product) =>
      _carts.indexWhere((cart) => cart.product.id == product.id);

  // Debug
  @override
  void onChange(Change<CartState> change) {
    print("current: ${change.currentState.status}" +
        "\n next: ${change.nextState.status}");
    super.onChange(change);
  }
}
