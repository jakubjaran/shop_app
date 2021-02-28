import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_list_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetItems(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(child: Text('Error!'));
            } else {
              return Column(children: [
                Expanded(
                  child: Consumer<Orders>(
                    builder: (ctx, orders, child) => orders.items.length > 0
                        ? ListView.builder(
                            itemCount: orders.items.length,
                            itemBuilder: (ctx, i) =>
                                OrderListItem(orders.items[i]),
                          )
                        : Center(
                            child: Text(
                                'No orders yet! Start buying stuff in our shop!'),
                          ),
                  ),
                ),
              ]);
            }
          }
        },
      ),
    );
  }
}
