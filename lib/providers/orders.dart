import 'package:flutter/foundation.dart';

import './cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime date;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void addOrder(List<CartItem> products, double amount) {
    _items.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        amount: amount,
        products: products,
        date: DateTime.now(),
      ),
    );
  }
}
