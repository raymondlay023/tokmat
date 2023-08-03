part of 'shop_cubit.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopLoading extends ShopState {}

class ShopAvailable extends ShopState {}

class ShopUnavailable extends ShopState {}

class AddShopSuccess extends ShopState {}

class AddShopFailure extends ShopState {}

class GetShopSuccess extends ShopState {
  final ShopEntity shop;

  const GetShopSuccess({required this.shop});

  @override
  List<Object> get props => [shop];
}

class GetShopFailure extends ShopState {}
