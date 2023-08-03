import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/injection_container.dart' as di;

import '../cubit/product_cubit.dart';
import 'widgets/product_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product list")),
      body: BlocProvider(
        create: (context) => di.sl<ProductCubit>()..getProducts(),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, productState) {
            if (productState is GetProductsSuccess) {
              ListView.builder(
                itemBuilder: (context, index) {
                  final product = productState.listProduct[index];
                  return ProductWidget(product: product);
                },
              );
            } else if (productState is ProductLoading) {
              return CircularProgressIndicator();
            } else if (productState is ProductFailure) {
              toast('Something went wrong!');
            }
            return NoProductsYetPage;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, PageConst.addProductPage),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget get NoProductsYetPage {
    return Center(child: Text('No products yet!'));
  }
}
