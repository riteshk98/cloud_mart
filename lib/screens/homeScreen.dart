import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_mart/models/address.dart';
import 'package:cloud_mart/providers/addressProvider.dart';
import 'package:cloud_mart/providers/cartProvider.dart';
import 'package:cloud_mart/screens/cartScreen.dart';
import 'package:cloud_mart/widgets/cartBadge.dart';
import 'package:cloud_mart/widgets/categoryScreenWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  showAddressSheet(Address defaultAdr) {
    final adrProvider = Provider.of<AddressProvider>(context, listen: false);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        'Default Address',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(defaultAdr.fullName +
                                ', ' +
                                defaultAdr.phone.toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(defaultAdr.address),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(defaultAdr.landmark),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(defaultAdr.pinCode.toString()),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 10),
                      child: Text(
                        'Saved Addresses',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                    FutureBuilder<List<Address>>(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Set<Address> addresses = snapshot.data.toSet();
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 180,
                                  child: ListView.builder(
                                      itemCount: addresses.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            adrProvider.changeDefaultAdr(
                                                addresses.elementAt(index));
                                            refresh();
                                            Navigator.pop(context);
                                          },
                                          child: ListTile(
                                            trailing: Icon(Icons.home),
                                            title: Text(addresses
                                                .elementAt(index)
                                                .address ??
                                                'Address'),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: LinearProgressIndicator());
                        }
                      },
                      future: adrProvider.addresses,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);

                          Navigator.of(context).pushNamed('/address');
                        },
                        icon: Icon(Icons.map),
                        label: Text(
                          'Add New Address',
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              ));
        });
  }

  refresh() {
    setState(() {
      final adrProvider = Provider.of<AddressProvider>(context, listen: false);
    });
  }

  Future<void> getProduct() async {
    await FirebaseFirestore.instance
        .collectionGroup('products')
        .get()
        .then((value) => print(value.docs.map((e) => e.data()))
    );
  }

  @override
  Widget build(BuildContext context) {
    final adrProvider = Provider.of<AddressProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          actions: [
            Consumer<CartProvider>(builder: (_, cart, ch) =>
                CartBadge(value: cart.itemCount.toString(),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined, color: Colors.black,
                        size: 26,)),
                ),
            )
          ],
          backgroundColor: Colors.white,
          title: Text(
            'Cloud Mart',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            FutureBuilder(
              future: Future.wait([adrProvider.defaultAddress,cartProvider.getCart()]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    GestureDetector(
                      onTap: () => showAddressSheet(snapshot.data[0]),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.tealAccent, Colors.amberAccent],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight)),
                        width: double.infinity,
                        child: Row(children: [
                          Text(
                            'Location :',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${snapshot.data[0].address}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                    )
                  ]);
                } else {
                  return Center(
                    child: LinearProgressIndicator(),
                  );
                }
              },
            ),
            Container(
              height: 40,
              child: Text(
                '  Explore All Categories',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              alignment: Alignment.bottomLeft,
            ),
            CategoryScreenWidget(),
            ElevatedButton(
                onPressed: () async => await getProduct(),
                child: Text('product'))
          ],
        ));
  }
}
