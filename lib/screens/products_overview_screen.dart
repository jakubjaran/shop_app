import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions {
  All,
  Favorites,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedVal) {
              setState(() {
                if (selectedVal == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show all'),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                child: Text('Favorites only'),
                value: FilterOptions.Favorites,
              ),
            ],
          )
        ],
      ),
      body: ProductsGrid(_showFavoritesOnly),
    );
  }
}
