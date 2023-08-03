part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class AddProductSuccess extends ProductState {}

class GetProductsSuccess extends ProductState {
  final List<ProductEntity> listProduct;

  const GetProductsSuccess({required this.listProduct});

  @override
  List<Object> get props => [listProduct];
}

class UpdateProductSuccess extends ProductState {}

class DeleteProductSuccess extends ProductState {}

class ProductLoading extends ProductState {}

class ProductFailure extends ProductState {}

class AddProductFailure extends ProductState {}
