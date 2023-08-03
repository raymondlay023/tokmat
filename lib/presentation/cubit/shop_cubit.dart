import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/shop_entity.dart';
import 'package:tokmat/domain/usecases/shop/create_shop_usecase.dart';
import 'package:tokmat/domain/usecases/shop/get_shop_usecase.dart';

import '../../domain/usecases/shop/update_shop_usecase.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  final CreateShopUseCase createShopUseCase;
  final GetShopUseCase getShopUseCase;
  final UpdateShopUseCase updateShopUseCase;

  ShopCubit({
    required this.createShopUseCase,
    required this.getShopUseCase,
    required this.updateShopUseCase,
  }) : super(ShopState.initial());

  Future<void> createShop(ShopEntity shop) async {
    emit(state.copyWith(status: ShopStatus.loading));
    try {
      await createShopUseCase.call(shop);
      emit(state.copyWith(status: ShopStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ShopStatus.failure));
    }
  }

  Future<void> getShop() async {
    emit(state.copyWith(status: ShopStatus.loading));
    try {
      final data = await getShopUseCase.call();
      print("shop getShop $data");
      emit(state.copyWith(shop: data, status: ShopStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ShopStatus.failure));
    }
  }

  Future<void> updateShop(ShopEntity shop) async {
    emit(state.copyWith(status: ShopStatus.loading));
    try {
      await updateShopUseCase.call(shop);
      emit(state.copyWith(status: ShopStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ShopStatus.failure));
    }
  }

  // Debug
  @override
  void onChange(Change<ShopState> change) {
    print("current: ${change.currentState.status}" +
        "\n next: ${change.nextState.status}");
    super.onChange(change);
  }
}
