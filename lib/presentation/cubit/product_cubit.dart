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
  }) : super(ProductInitial());

  Future<void> getProducts() async {
    try {
      final streamResponse = await getProductsUseCase.call();
      streamResponse.listen(
          (listProduct) => emit(GetProductsSuccess(listProduct: listProduct)));
    } catch (_) {
      emit(ProductFailure());
    }
  }

  Future<void> createProduct(ProductEntity product) async {
    try {
      await createProductUseCase.call(product);
      emit(AddProductSuccess());
    } catch (_) {
      emit(AddProductFailure());
    }
  }

  // Debug
  @override
  void onChange(Change<ProductState> change) {
    print("current: ${change.currentState}" + "\n next: ${change.nextState}");
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print("$error, $stackTrace");
    super.onError(error, stackTrace);
  }
}
