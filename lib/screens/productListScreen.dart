import 'package:cloud_mart/providers/productProvider.dart';
import 'package:cloud_mart/screens/productDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductListScreen extends StatelessWidget {
  static const routeName = '/product-list';

  @override
  Widget build(BuildContext context) {
    final subcategory = ModalRoute.of(context).settings.arguments as String;
    final products =
        Provider.of<ProductProvider>(context, listen: true).subProducts;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            subcategory.toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: products.isEmpty || products.length == 0
            ? Center(
                child: Text('No Products Added in this Category'),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(
                        left: 10, bottom: 14, top: 18, right: 5),
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {Navigator.of(context).pushNamed(ItemDetailsScreen.routeName,arguments: products[index]);},
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.2),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12))),
                            child: Row(children: [
                              Container(
                                child: FadeInImage.assetNetwork(
                                    width: 125,
                                    height: 125,
                                    placeholder: 'assets/loading.png',
                                    image: products[index].imageUrl ??
                                        'https://homepages.cae.wisc.edu/~ece533/images/airplane.png'),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade50),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (products[index].productName),
                                      style: TextStyle(
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(height: 9),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '₹' +
                                              products[index].price.toString(),
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 19),
                                        Text(
                                          '50 gm',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    )
                                  ])
                            ])),
                      );
                    },
                  ),
                ],
              ));
  }
}
