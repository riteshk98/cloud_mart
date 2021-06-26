import 'package:cloud_mart/models/cart.dart';
import 'package:cloud_mart/providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Your Cart',
          style: TextStyle(color: Colors.black),
        ),),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getCart(),
              builder: (context, snap) {
                if (snap.connectionState== ConnectionState.done) {
                  final snapShot = cart.cart;
                  if(snapShot.isEmpty){
                    return Text('No Products added in Cart!');
                  }else{
                    return Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(trailing: Text(snapShot[index].quantity.toString()+ ' x ₹${snapShot[index].price.toStringAsFixed(0)}'),
                              title: Text(snapShot[index].name),
                            );
                          },
                          itemCount: snapShot.length,
                        ),ListTile(title: Text('Total'),trailing: Text(cart.total.toStringAsFixed(0)),)
                      ],
                    );
                  }

                } else {
                  return Text('Loading');
                }
              })
        ],
      ),
    );
  }
}
