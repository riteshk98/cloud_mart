import 'package:cloud_mart/models/product.dart';
import 'package:cloud_mart/providers/cartProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemDetailsScreen extends StatelessWidget {
  static const routeName = '/item-details-screen';
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Product;
    final cartProvider = Provider.of<CartProvider>(context,listen: false);
    return Scaffold(key: _key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Detail Screen',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 55),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/loading.png',
                image: product.imageUrl ??
                    'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
                fit: BoxFit.fill,
                height: 250,
                width: double.infinity,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 9, left: 15),
                    child: Text(
                      '${product.productName}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 28),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 9, right: 15),
                    child: Text(
                      '₹' + product.price.toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3, left: 15),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Details',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: '\nBrand : ' + product.brand,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: '\nWeight : ' +
                                              product.weight,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: '\nDescription : ' +
                                              product.description,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal)),
                                    ]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9),
                            child: Material(
                                borderRadius: BorderRadius.circular(15.0),
                                color: product.inStock?Colors.indigo:Colors.grey,
                                elevation: 0.0,
                                child: MaterialButton(
                                  elevation: 20,
                                  onPressed: product.inStock?() async
                                      {
                                        bool success = await cartProvider.addToCart(product);

                                    // bool success = await userProvider.addToCart(
                                    //     product: widget.product,
                                    //     color: _color,
                                    //     size: _size);
                                    if (success) {
                                      _key.currentState.showSnackBar(
                                          SnackBar(content: Text("Added to Cart!")));
                                    //   userProvider.reloadUserModel();
                                    //   appProvider.changeIsLoading();
                                      return;
                                    } else {
                                      _key.currentState.showSnackBar(SnackBar(
                                          content: Text("Not added to Cart!")));
                                    //   appProvider.changeIsLoading();
                                      return;
                                    }
                                  }:null,
                                  minWidth: MediaQuery.of(context).size.width,
                                  child:product.inStock?
                                      // appProvider.isLoading
                                      //     ? Loading():
                                      Text(
                                    'Add to cart',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ):Text('Out of Stock'),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ])))
          ],
        )),
      ),
    );
  }
}
