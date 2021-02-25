import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_list_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetItems();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
