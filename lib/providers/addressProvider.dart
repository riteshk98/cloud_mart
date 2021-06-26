import 'package:cloud_mart/models/address.dart';
import 'package:cloud_mart/services/firestoreService.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddressProvider with ChangeNotifier {
  var firestoreService = FirestoreService.firestoreService;
  String _adrId;
  String _fullName;
  int _phone;
  String _address;
  int _pinCode;
  String _landmark;
  var uuid = Uuid();

  String get adrId => _adrId;

  String get fullName => _fullName;

  int get phone => _phone;

  String get address => _address;


  int get pinCode => _pinCode;

  String get landmark => _landmark;

  Future<List<Address>> get addresses => firestoreService.getAddress();
  Future<Address> get defaultAddress => firestoreService.getDefaultAddress();


  set changeLandmark(String value) {
    _landmark = value;
    notifyListeners();
  }

  set changePinCode(int value) {
    _pinCode = value;
    notifyListeners();
  }

  set changeAddress(String value) {
    _address = value;
    notifyListeners();
  }
  set changePhone(int value) {
    _phone = value;
    notifyListeners();
  }

  set changeFullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  set changeAdrId(String value) {
    _adrId = value;
    notifyListeners();
  }

  loadAll(Address address) {
    if (address != null) {
      _phone = address.phone;
      _address = address.address;
      _adrId = address.adrId;
      _fullName = address.fullName;
      _pinCode = address.pinCode;
      _landmark = address.landmark;
    }}


  changeDefaultAdr(Address value){
    firestoreService.setDefaultAddress(value);
    notifyListeners();
  }

    saveAddress() {
      if (_adrId == null) {
        //add
        var newAdr = Address(
            adrId: uuid.v1(),
            landmark: _landmark,
            fullName: _fullName,
            address: _address,
            phone: _phone,
            pinCode: _pinCode);
        firestoreService.setAddress(newAdr);
        changeDefaultAdr(newAdr);
      } else {
        var updateAdr = Address(
            adrId: _adrId,
            landmark: _landmark,
            fullName: _fullName,
            address: _address,
            phone: _phone,
            pinCode: _pinCode);
        changeDefaultAdr(updateAdr);
        firestoreService.setAddress(updateAdr);
        //update
      }
    }
    removeAdr(String adrId){

      
    }

  }

