import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  final String authToken;

  Products(this.authToken, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addItem(Product product) async {
    final url =
        'https://shopapp-c2c88-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken';

    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updateItem(String id, Product updatedProduct) async {
    final productIndex = _items.indexWhere((item) => item.id == id);
    if (productIndex >= 0) {
      final url =
          'https://shopapp-c2c88-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken';
      await http.patch(
        url,
        body: json.encode({
          'title': updatedProduct.title,
          'imageUrl': updatedProduct.imageUrl,
          'description': updatedProduct.description,
          'price': updatedProduct.price,
        }),
      );
      _items[productIndex] = updatedProduct;
      notifyListeners();
    }
  }

  Future<void> deleteItem(String id) async {
    final url =
        'https://shopapp-c2c88-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((item) => item.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeWhere((item) => item.id == id);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Deleting failed!');
    }

    existingProduct = null;
  }

  Future<void> fetchAndSetItems() async {
    final url =
        'https://shopapp-c2c88-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (data == null) {
        return;
      }
      data.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          imageUrl: prodData['imageUrl'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
