import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_list_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: orders.items.length,
                itemBuilder: (ctx, i) => OrderListItem(orders.items[i])),
          ),
        ],
      ),
    );
  }
}
