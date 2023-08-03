import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/domain/usecases/product/create_product_usecase.dart';
import 'package:tokmat/domain/usecases/product/get_products_use_case.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final CreateProductUseCase createProductUseCase;
  final GetProductsUseCase getProductsUseCase;
  ProductCubit({
    required this.createProductUseCase,
    required this.getProductsUseCase,
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

  // Debug
  @override
  void onChange(Change<ProductState> change) {
    print("current: ${change.currentState.status}" +
        "\n next: ${change.nextState.status}");
    super.onChange(change);
  }
}
