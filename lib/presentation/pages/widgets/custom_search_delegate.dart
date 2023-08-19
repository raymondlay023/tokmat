import 'package:flutter/material.dart';

class CustomSearchDelegate<T> extends SearchDelegate {
  final List<T> items;
  final String Function(T) itemToString;

  CustomSearchDelegate({
    required this.items,
    required this.itemToString,
  });

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
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    return Center(child: Text(query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<T> suggestions = items.where((item) {
      final result = itemToString(item).toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(itemToString(suggestion)),
        );
      },
    );
  }
}
