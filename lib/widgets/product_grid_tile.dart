import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;

  ProductGridTile(this.product);

  @override
  Widget build(BuildContext context) {
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
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
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
            leading: IconButton(
              icon: Icon(Icons.favorite_outline),
              onPressed: () {},
              color: Theme.of(context).accentColor,
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
