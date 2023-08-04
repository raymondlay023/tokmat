import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tokmat/core/const.dart';
import 'package:tokmat/core/utils.dart';
import 'package:tokmat/injection_container.dart' as di;

import '../cubit/product_cubit.dart';
import 'widgets/product_tile_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

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
                showSearch(context: context, delegate: MySearchDelegate());
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, productState) {
          if (productState.status == ProductStatus.success) {
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
          return NoProductsYetPage;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, PageConst.addProductPage),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget get NoProductsYetPage {
    return const Center(child: Text('No products yet!'));
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = ['produk 2', 'produk 3'];
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context, null); // close searchbar
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.close)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
