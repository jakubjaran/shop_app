import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' show Order;

class OrderListItem extends StatefulWidget {
  final Order order;

  OrderListItem(this.order);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  var _expanded = false;

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
      child: Column(
        children: [
          ListTile(
            leading: Chip(
              label: Text(
                '\$${widget.order.amount.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Theme.of(context).accentColor,
            ),
            title: Text(
              DateFormat('dd/MM/yyyy | hh:mm').format(widget.order.date),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 30, 80),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ListView(
                children: widget.order.products
                    .map((prod) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(prod.title),
                              Text('${prod.quantity}x \$${prod.price}'),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
