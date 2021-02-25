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

  Future<void> fetchAndSetItems() async {
    const url =
        'https://shopapp-c2c88-default-rtdb.europe-west1.firebasedatabase.app/orders.json';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body);
      final List<Order> loadedOrders = [];
      if (data == null) {
        return;
      }
      data.forEach((orderId, orderData) {
        final products = orderData['products']
            .map<CartItem>((product) => CartItem(
                  id: product['id'],
                  title: product['title'],
                  price: product['price'],
                  quantity: product['quantity'],
                ))
            .toList();
        loadedOrders.insert(
            0,
            Order(
              id: orderId,
              amount: orderData['amount'],
              products: products,
              date: DateTime.parse(orderData['date']),
            ));
      });
      _items = loadedOrders;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> addOrder(List<CartItem> products, double amount) async {
    const url =
        'https://shopapp-c2c88-default-rtdb.europe-west1.firebasedatabase.app/orders.json';
    final timestamp = DateTime.now();
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
          'date': timestamp.toIso8601String(),
        }),
      );

      final newOrder = Order(
        id: json.decode(response.body)['name'],
        amount: amount,
        products: products,
        date: timestamp,
      );

      _items.insert(0, newOrder);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
