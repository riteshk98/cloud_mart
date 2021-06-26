import 'package:cloud_mart/models/address.dart';
import 'package:cloud_mart/models/product.dart';
import 'package:cloud_mart/services/firestoreService.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  var firestoreService = FirestoreService.firestoreService;
   String _productId;
   String _productName;
   int _price;
   bool _inStock;
   String _weight;
   String _description;
   String _brand;
  var uuid = Uuid();

  bool get inStock => _inStock;

  String get productId => _productId;

  String get productName => _productName;

  int get price => _price;

  String get weight => _weight;


  String get description => _description;

  String get brand => _brand;

  List<Product> _subProducts = [];

  List<Product> get subProducts {
    return [..._subProducts];
  }
  Future<void>  getProducts(String catId, String subCatId) async{
    var loadedPRs = await firestoreService.getSubProducts(catId,subCatId);
    _subProducts = loadedPRs;
    notifyListeners();
  }



  set changeProductId(String value) {
    _productId = value;
    notifyListeners();
  }
  set changeInStock(bool value) {
    _inStock = value;
    notifyListeners();
  }

  set changePrice(int value) {
    _price = value;
    notifyListeners();
  }

  set changeProductName(String value) {
    _productName = value;
    notifyListeners();
  }
  set changeDescription(String value) {
    _description = value;
    notifyListeners();
  }

  set changeBrand(String value) {
    _brand = value;
    notifyListeners();
  }

  set changeWeight(String value) {
    _weight = value;
    notifyListeners();
  }

  loadAll(Product product) {
    if (product != null) {
      _weight = product.weight;
      _brand = product.brand;
      _inStock = product.inStock;
      _description = product.description;
      _price = product.price;
      _productName = product.productName;
      _productId = product.productId;
    }}


  saveProduct() {
    if (_productId == null) {
      //add
      var newProduct = Product(
          productId: uuid.v1(),
          description:_description,
          inStock: _inStock,
          productName: _productName,
          price: _price,
          brand:_brand,
          weight: _weight);
      // firestoreService.setProduct(newProduct);
    } else {
      var updateProduct = Product(
          productId: _productId,
          description:_description,
          inStock: _inStock,
          productName: _productName,
          price: _price,
          brand:_brand,
          weight: _weight);
      // firestoreService.setProduct(updateProduct);
      //update
    }
  }

}

