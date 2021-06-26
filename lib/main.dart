import 'package:cloud_mart/providers/addressProvider.dart';
import 'package:cloud_mart/providers/cartProvider.dart';
import 'package:cloud_mart/providers/categoryProvider.dart';
import 'package:cloud_mart/providers/productProvider.dart';
import 'package:cloud_mart/screens/addressSelectScreen.dart';
import 'package:cloud_mart/screens/cartScreen.dart';
import 'package:cloud_mart/screens/extraScreen.dart';
import 'package:cloud_mart/screens/productDetailScreen.dart';
import 'package:cloud_mart/screens/productListScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ProductProvider())
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Google Maps Demo',
        home: HomeScreen(),
        routes: {
          '/address': (context) => AddressSelectScreen(),
          ItemDetailsScreen.routeName: (context) => ItemDetailsScreen(),
          CartScreen.routeName : (context) => CartScreen(),
          ProductListScreen.routeName: (context) => ProductListScreen()
        },
      ),
    );
  }
}
