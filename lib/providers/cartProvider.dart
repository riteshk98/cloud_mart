import 'package:cloud_mart/models/cart.dart';
import 'package:cloud_mart/models/product.dart';
import 'package:cloud_mart/services/firestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  var firestoreService = FirestoreService.firestoreService;
  String _productId;
  int _price;
  String _id;
  String _title;
  int _quantity;
  var uuid = Uuid();

  String get productId => _productId;

  int get price => _price;

  String get id => _id;

  String get title => _title;

  int get quantity => _quantity;

  List<CartItem> _cartItems = [];

  List<CartItem> get cart {
    return [..._cartItems];
  }

  int get itemCount {
    return _cartItems.length;
  }
  double get total {
    double total =0;
    _cartItems.forEach((element) {total = total +(element.quantity*element.price);});
    return total;
  }

  Future<bool> addToCart(Product product) async {
    try {
      final cartPr =
          _cartItems.where((element) => element.productId == product.productId);
      if (cartPr == null || cartPr.isEmpty) {
        CartItem cart1 = CartItem(
            price: product.price.toDouble(),
            quantity: 1,
            name: product.productName,
            productId: product.productId);
        await firestoreService.addToCart(cart1);
        _cartItems.add(cart1);
        notifyListeners();
      } else {
        CartItem cart1 = CartItem(
            price: cartPr.first.price,
            quantity: cartPr.first.quantity + 1,
            name: cartPr.first.name,
            productId: cartPr.first.productId);
        await firestoreService.addToCart(cart1);
        cartPr.first.quantity = cartPr.first.quantity+1;
        notifyListeners();

      }

      // Map cartItem = {
      //   'id': cartItemId,
      //   'name':product.productName,
      //   'image': product.imageUrl,
      //   'price': product.price,
      //   'productId': product.productId,
      //   'weight':product.weight
      // };
      // CartItem item = CartItem.fromJson(cartItem);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getCart() async {
    _cartItems = await firestoreService.getCart();
    notifyListeners();
  }
}
