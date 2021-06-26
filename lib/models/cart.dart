import 'package:flutter/cupertino.dart';

class CartItem {

  final String productId;
  final String name;
  int quantity;
  final double price;

  CartItem(
      {
       this.productId,
       this.name,
       this.quantity,
       this.price});


  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        productId: json['productId'],
        price: json['price'],
        quantity: json['quantity'],
      name: json['name'],
        );
  }


  Map<String,dynamic> toMap(){
    return {
      'productId' : productId,
      'name': name,
      'price': price,
      'quantity':quantity,
    };
  }
}


