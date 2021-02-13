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
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    int totalCount = 0;
    _items.forEach((key, item) {
      totalCount += item.quantity;
    });
    return totalCount;
  }

  int itemQuanity(String id) {
    return _items.containsKey(id) ? _items[id].quantity : 0;
  }

  void addItem(String id, String title, double price) {
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
    notifyListeners();
  }
}
