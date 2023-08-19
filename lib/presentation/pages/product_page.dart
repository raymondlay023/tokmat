import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/domain/entities/product_entity.dart';
import 'package:tokmat/presentation/pages/widgets/custom_search_delegate.dart';

import '../cubit/product_cubit.dart';
import 'widgets/product_tile_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late List<ProductEntity> _products;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Daftar Produk"),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                        context: context,
                        delegate: ProductSearchDelegate(products: _products))
                    .then((value) {
                  setState(() {});
                });
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, productState) {
          if (productState.status == ProductStatus.success) {
            _products = productState.products;
            return ListView.builder(
              itemCount: productState.products.length,
              itemBuilder: (context, index) {
                final product = productState.products[index];
                return ProductTileWidget(product: product);
              },
            );
          } else if (productState.status == ProductStatus.failure) {
            toast('Something went wrong!');
          }
          return noProductsYetPage;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, PageConst.addProductPage),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget get noProductsYetPage {
    return const Center(
        child: Text(
      'No products yet!',
      style: TextStyle(fontSize: 30),
    ));
  }
}

class ProductSearchDelegate extends CustomSearchDelegate<ProductEntity> {
  ProductSearchDelegate({required List<ProductEntity> products})
      : super(
          items: products,
          itemToString: (product) => product.name!,
        );

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductEntity> suggestions = items.where((product) {
      final result = product.name!.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ProductTileWidget(product: suggestion);
      },
    );
  }
}
