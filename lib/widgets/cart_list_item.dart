import 'package:flutter/material.dart';

class CartListItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartListItem(this.id, this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
        color: Colors.white,
      ),
      child: ListTile(
        leading: Chip(
          label: Text(
            '\$${(price * quantity)}',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
        title: Text(title),
        subtitle: Text('Item price: \$$price'),
        trailing: Text(
          '$quantity x',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
