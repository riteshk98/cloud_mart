import 'package:cloud_mart/models/category.dart';
import 'package:cloud_mart/services/firestoreService.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class CategoryProvider with ChangeNotifier{
  var firestoreService = FirestoreService.firestoreService;
  String _catID;
  String _name;
  var uuid = Uuid();

  String get catID => _catID;

  String get name => _name;

  Future<List<Category>> get categories => firestoreService.getFin();

  set changeName(String value) {
    _name = value;
    notifyListeners();
  }

  set changeCatId(String value) {
    _catID = value;
    notifyListeners();
  }

  loadAll(Category category){
    if(category !=null){
      _catID = category.categoryId;
      _name = category.name;
    }
  }

  saveCategory() {
    if (_catID == null) {
      //add
      var newCategory = Category(
          categoryId: uuid.v1(),name: _name);
      firestoreService.setCategory(newCategory);
    } else {
      var updateCategory = Category(categoryId: _catID,name: _name);
      firestoreService.setCategory(updateCategory);
      //update
    }
  }
}
