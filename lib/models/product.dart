import 'package:flutter/foundation.dart';

class Product {
  final String productId;
  final String productName;
  final int price;
  final String weight;
  final String description;
  final String brand;
  final imageUrl;
  final bool inStock;


  Product({this.productId, this.productName, this.price, this.weight,
      this.description, this.brand,this.inStock,this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productId: json['productId'],
        productName: json['productName'],
        price: json['price'],
        imageUrl: json['imageUrl'],
        weight: json['weight'],
        inStock: json['inStock'],
        description: json['description'],
        brand: json['brand']);
  }

  Map<String,dynamic> toMap(){
    return {
      'productId' : productId,
      'productName': productName,
      'price': price,
      'inStock':inStock,
      'weight': weight,
      'description': description,
      'brand': brand
    };
  }
}
