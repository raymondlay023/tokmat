import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/usecases/product/create_product_usecase.dart';
import 'package:tokmat/domain/usecases/product/get_products_use_case.dart';

import '../../domain/usecases/product/delete_product_usecase.dart';
import '../../domain/usecases/product/update_product_usecase.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final CreateProductUseCase createProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductCubit({
    required this.getProductsUseCase,
    required this.createProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  }) : super(ProductState.initial());

  Future<void> getProducts() async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final streamResponse = await getProductsUseCase.call();
      streamResponse.listen((products) {
        emit(state.copyWith(products: products, status: ProductStatus.success));
        print("products getProducts : $products");
      });
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

  Future<void> createProduct(ProductEntity product) async {
    try {
      emit(state.copyWith(status: ProductStatus.loading));
      await createProductUseCase.call(product);
      emit(state.copyWith(status: ProductStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

  Future<void> updateProduct(ProductEntity product) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      await updateProductUseCase.call(product);
      emit(state.copyWith(status: ProductStatus.success));
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

  Future<void> deleteProduct(String productId) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      print("productId delete cubit $productId");
      await deleteProductUseCase.call(productId);
      emit(state.copyWith(status: ProductStatus.success));
      // if (productId != null && productId != "") {
      //   await deleteProductUseCase.call(productId);
      //   emit(state.copyWith(status: ProductStatus.success));
      // } else {
      //   emit(state.copyWith(status: ProductStatus.failure));
      //   toast("id null");
      // }
    } catch (_) {
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

  // Debug
  @override
  void onChange(Change<ProductState> change) {
    print("current: ${change.currentState.status}" +
        "\n next: ${change.nextState.status}");
    super.onChange(change);
  }
}
