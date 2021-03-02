import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/badge.dart';
import '../providers/products.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/details-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;

    final loadedProduct = Provider.of<Products>(context).findById(productId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            title: Text(loadedProduct.title),
            actions: [
              Consumer<Cart>(
                builder: (_, cart, child) => Badge(
                  value: cart.itemsCount.toString(),
                  child: child,
                ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(loadedProduct.imageUrl),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: [
                    Text(
                      loadedProduct.title,
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${loadedProduct.price}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                    Consumer<Cart>(
                      builder: (_, cart, child) => FlatButton(
                        onPressed: () {
                          cart.addItem(loadedProduct.id, loadedProduct.title,
                              loadedProduct.price);
                        },
                        child: child,
                        textColor: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        '+ ADD TO CART',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  softWrap: true,
                ),
              ),
              SizedBox(height: 800),
            ]),
          ),
        ],
      ),
    );
  }
}
