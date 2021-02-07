import 'package:flutter/material.dart';

import './screens/products_overview_screen.dart';
import './screens/product_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        accentColor: Colors.orangeAccent,
        fontFamily: 'Lato',
      ),
      routes: {
        '/': (ctx) => ProductsOverviewScreen(),
        ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
      },
    );
  }
}
