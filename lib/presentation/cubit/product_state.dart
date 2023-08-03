part of 'product_cubit.dart';

enum ProductStatus { initial, success, loading, failure }

class ProductState extends Equatable {
  final List<ProductEntity> products;
  final ProductStatus status;

  const ProductState({required this.products, required this.status});

  factory ProductState.initial() =>
      ProductState(products: List.empty(), status: ProductStatus.initial);

  ProductState copyWith({
    List<ProductEntity>? products,
    ProductStatus? status,
  }) {
    return ProductState(
      products: products ?? this.products,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [products];
}
