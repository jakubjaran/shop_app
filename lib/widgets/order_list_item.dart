import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' show Order;

class OrderListItem extends StatelessWidget {
  final Order order;

  OrderListItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: ListTile(
        leading: Chip(
          label: Text(
            '\$${order.amount.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).accentColor,
        ),
        title: Text(
          DateFormat('dd/MM/yyyy | hh:mm').format(order.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () {},
        ),
      ),
    );
  }
}
