import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductsItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 0),
        leading: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
          ),
          width: 60,
          height: double.infinity,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                color: Theme.of(context).accentColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Are you sure?'),
                      content:
                          Text('Do you really want to delete that product?'),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('NO'),
                          textColor: Theme.of(context).accentColor,
                        ),
                        FlatButton(
                          onPressed: () async {
                            try {
                              Navigator.of(ctx).pop();
                              await Provider.of<Products>(context,
                                      listen: false)
                                  .deleteItem(id);
                            } catch (error) {
                              scaffold.showSnackBar(
                                SnackBar(
                                  content: Text('Deleting failed!'),
                                ),
                              );
                              Navigator.of(ctx).pop();
                            }
                          },
                          child: Text('YES'),
                          textColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
