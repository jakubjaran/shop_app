import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_details_screen.dart';

class ProductGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6),
        ],
      ),
      child: GridTile(
        header: GridTileBar(
          title: Text(
            '\$${product.price.toString()}',
            style: TextStyle(
              background: Paint()
                ..color = Theme.of(context).primaryColor
                ..strokeWidth = 17
                ..style = PaintingStyle.stroke,
            ),
            textAlign: TextAlign.end,
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
                onPressed: () {
                  product.toggleFavorite();
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
