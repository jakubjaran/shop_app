import 'package:flutter/material.dart';

import '../screens/product_details_screen.dart';

class ProductGridTile extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  ProductGridTile(
    this.id,
    this.title,
    this.imageUrl,
    this.price,
  );

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
            '\$${price.toString()}',
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
              arguments: id,
            );
          },
          child: Image.network(
            imageUrl,
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
              title,
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
