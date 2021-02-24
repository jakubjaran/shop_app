import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addOrder(List<CartItem> products, double amount) async {
    const url =
        'https://shopapp-c2c88-default-rtdb.europe-west1.firebasedatabase.app/orders.json';
    final date = DateTime.now().toIso8601String();
    final productsList = products.map((product) {
      return {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'quantity': product.quantity,
      };
    }).toList();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': amount,
          'products': productsList,
          'date': date,
        }),
      );

      final newOrder = Order(
        id: json.decode(response.body)['name'],
        amount: amount,
        products: products,
        date: DateTime.now(),
      );

      _items.insert(0, newOrder);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
