import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/cart.dart';
import '../screens/product_details_screen.dart';
import '../widgets/badge.dart';

class ProductGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: GridTile(
        header: GridTileBar(
          title: SizedBox(),
          trailing: Chip(
            label: Text('\$${product.price}'),
            backgroundColor: Theme.of(context).accentColor,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Theme.of(context).accentColor, width: 2),
            ),
          ),
          child: GridTileBar(
            backgroundColor: Colors.white,
            title: Text(
              product.title,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            leading: Consumer<Product>(
              builder: (ctx, product, child) => IconButton(
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () async {
                  try {
                    await product.toggleFavorite();
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text('Toggling favorite status failed!'),
                      ),
                    );
                  }
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            trailing: Badge(
              value: cart.itemQuanity(product.id).toString(),
              color: Colors.redAccent,
              child: IconButton(
                icon: Icon(
                  cart.itemQuanity(product.id) > 0
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                ),
                onPressed: () {
                  cart.addItem(product.id, product.title, product.price);
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added item to cart!'),
                      duration: Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        },
                      ),
                    ),
                  );
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
