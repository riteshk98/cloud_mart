import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_mart/models/address.dart';
import 'package:cloud_mart/models/cart.dart';
import 'package:cloud_mart/models/category.dart';
import 'package:cloud_mart/models/product.dart';

class FirestoreService {
  static final firestoreService = FirestoreService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Get
  Future<List<Address>> getAddress() {
    return _firestore
        .collection('address')
        .where(FieldPath.documentId, isNotEqualTo: 'default')
        .get()
        .then((value) =>
            value.docs.map((doc) => Address.fromJson(doc.data())).toList());
  }

  Future<List<CartItem>> getCart() {
    return _firestore.collection('cart').get().then(
        (value) => value.docs.map((e) => CartItem.fromJson(e.data())).toList());
  }

  Future<List<Product>> getSubProducts(String catId, String subCatId) async {
    return _firestore
        .collection(
            '/categories/${catId.trim()}/subCategory/${subCatId.trim()}/products'
                .trim())
        .get()
        .then((value) =>
            value.docs.map((e) => Product.fromJson(e.data())).toList());
  }

  Future<void> getProduct() async {
    _firestore
        .collectionGroup('products')
        .get()
        .then((value) => value.docs.map((e) => print(e.data())));
  }

  Future<List<SubCategory>> getSubs(String id) async {
    return _firestore
        .collection('/categories/${id.trim()}/subCategory')
        .get()
        .then((value) =>
            value.docs.map((e) => SubCategory.fromJson(e.data())).toList());
  }

  Future<List<Category>> getCategory() async {
    return await _firestore.collection('categories').get().then((value) {
      return value.docs.map((doc) {
        return Category.fromJson(
          doc.data(),
        );
      }).toList();
    });
  }

  Future<List<Category>> getFin() async {
    var c = await getCategory();
    for (int i = 0; i < c.length; i++) {
      var s = await getSubs(c[i].categoryId);
      c.elementAt(i).subCategory = s;
    }
    // var s = await getSubs(c.first.categoryId);
    // print(s.length);
    // c.elementAt(0).subCategory =s;
    // c.elementAt(1).subCategory =s;

    return c;
  }

  Future<Address> getDefaultAddress() async {
    Address adr;
    await _firestore
        .doc('address/default')
        .get()
        .then((value) => adr = Address.fromJson(value.data()));
    return adr;
  }

  Future<void> addToCart(CartItem cartItem) async {
    var options = SetOptions(merge: true);
    return await _firestore
        .collection('cart')
        .doc(cartItem.productId)
        .set(cartItem.toMap(), options);
  }

  Future<void> changeCartQuantity(CartItem cartItem) async {
    var options = SetOptions(merge: true);
    return await _firestore
        .collection('cart')
        .doc(cartItem.productId)
        .set(cartItem.toMap(), options);
  }


  //Upsert

  Future<void> setAddress(Address address) async {
    var options = SetOptions(merge: true);
    // var defaultAdr = await _firestore
    //     .collection('address')
    //     .doc('default')
    //     .set(address.toMap(), options);
    await setDefaultAddress(address);
    return await _firestore
        .collection('address')
        .doc(address.adrId)
        .set(address.toMap(), options);
  }

  Future<void> setCategory(Category category) async {
    var options = SetOptions(merge: true);
    return await _firestore
        .collection('categories')
        .doc(category.categoryId)
        .set(category.toMap(), options);
  }

  Future<void> setDefaultAddress(Address address) async {
    var options = SetOptions(merge: true);
    return await _firestore
        .collection('address')
        .doc('default')
        .set(address.toMap(), options);
  }

  //delete
  Future<void> removeAddress(String addressId) {
    return _firestore.collection('address').doc(addressId).delete();
  }
}
