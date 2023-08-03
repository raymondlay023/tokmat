part of 'shop_cubit.dart';

enum ShopStatus { initial, success, loading, failure }

class ShopState extends Equatable {
  final ShopEntity shop;
  final ShopStatus status;

  const ShopState({required this.shop, required this.status});

  factory ShopState.initial() =>
      ShopState(shop: ShopEntity(), status: ShopStatus.initial);

  ShopState copyWith({ShopEntity? shop, ShopStatus? status}) {
    return ShopState(shop: shop ?? this.shop, status: status ?? this.status);
  }

  @override
  List<Object> get props => [shop, status];
}
