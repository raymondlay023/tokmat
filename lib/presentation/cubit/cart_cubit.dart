import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/product_entity.dart';

import '../../domain/entities/cart_entity.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  List<CartEntity> get _carts => state.cartList;

  void addCart(ProductEntity product) {
    if (!_productExist(product)) {
      _carts.add(CartEntity(
        id: _carts.length,
        product: product,
        amount: 1,
      ));
    } else {
      int index = _getIndexByProduct(product);
      _carts[index].amount++;
    }
    print("addCart _carts : $_carts");
    emit(CartState(cartList: _carts, status: CartStatus.added));
  }

  void removeCartById(int id) {
    int index = _getIndexById(id);
    _carts.removeAt(index);
    emit(CartState(cartList: _carts, status: CartStatus.removed));
  }

  void removeCart(ProductEntity product) {
    int index = _getIndexByProduct(product);
    _carts.removeAt(index);
    emit(CartState(cartList: _carts, status: CartStatus.removed));
  }

  void addQuantity(int id) {
    int index = _getIndexById(id);
    _carts[index].amount++;
    emit(CartState(cartList: _carts, status: CartStatus.updated));
  }

  void reduceQuantity(int id) {
    int index = _getIndexById(id);
    if (_carts[index].amount > 0) {
      _carts[index].amount--;
    } else {
      removeCartById(id);
    }
    emit(CartState(cartList: _carts, status: CartStatus.updated));
  }

  int _getIndexById(int id) => _carts.indexWhere((cart) => cart.id == id);

  int _getIndexByProduct(ProductEntity product) =>
      _carts.indexWhere((cart) => cart.product.id == product.id);

  bool _productExist(ProductEntity product) {
    if (_getIndexByProduct(product) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
