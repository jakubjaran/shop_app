import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';

import '../widgets/cart_list_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;
  var _canOrder = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 6),
              ],
            ),
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Theme.of(context).accentColor,
                ),
                FlatButton(
                  onPressed: cart.itemsCount > 0
                      ? () async {
                          setState(() {
                            _isLoading = true;
                          });
                          await orders.addOrder(
                            cart.items.values.toList(),
                            cart.totalAmount,
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          cart.clear();
                        }
                      : null,
                  disabledTextColor: Colors.grey,
                  textColor: Theme.of(context).primaryColor,
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'ORDER NOW',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) {
                var item = cart.items.values.toList()[i];
                return CartListItem(
                  item.id,
                  item.title,
                  item.price,
                  item.quantity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
