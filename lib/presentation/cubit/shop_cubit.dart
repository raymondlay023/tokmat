import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/domain/usecases/shop/create_shop_usecase.dart';
import 'package:tokmat/domain/usecases/shop/get_shop_usecase.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final CreateShopUseCase createShopUseCase;
  final GetShopUseCase getShopUseCase;
  ShopCubit({
    required this.createShopUseCase,
    required this.getShopUseCase,
  }) : super(ShopInitial());

  Future<void> createShop(ShopEntity shop) async {
    emit(ShopLoading());
    try {
      await createShopUseCase.call(shop);
      emit(AddShopSuccess());
    } catch (_) {
      emit(AddShopFailure());
    }
  }

  Future<void> getShop() async {
    emit(ShopLoading());
    try {
      final data = await getShopUseCase.call();
      print("shop getShop $data");
      emit(GetShopSuccess(shop: data));
    } catch (_) {
      emit(GetShopFailure());
    }
  }

  Future<void> appStarted(BuildContext context) async {
    emit(ShopLoading());
    try {
      final data = await getShopUseCase.call();
      emit(ShopAvailable());
      print("shop getShop $data");
    } catch (_) {
      emit(ShopUnavailable());
    }
  }

  // Debug
  @override
  void onChange(Change<ShopState> change) {
    print("current: ${change.currentState}" + "\n next: ${change.nextState}");
    super.onChange(change);
  }
}
