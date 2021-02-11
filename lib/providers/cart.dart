import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items;

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addCartItem(String id, String title, double price) {
    _items.update(
      id,
      (existingItem) => CartItem(
        id: existingItem.id,
        title: existingItem.title,
        price: existingItem.price,
        quantity: existingItem.quantity + 1,
      ),
      ifAbsent: () => CartItem(
        id: id,
        title: title,
        price: price,
        quantity: 1,
      ),
    );
  }
}
