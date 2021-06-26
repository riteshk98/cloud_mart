import 'package:flutter/foundation.dart';

class Address {
  final String adrId;
  final String fullName;
  final int phone;
  final String address;
  final int pinCode;
  final String landmark;
  Address(
      {@required this.adrId,
      this.fullName,
      this.phone,
      this.address,
      this.pinCode,
      this.landmark});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        phone: json['phone'],
        address: json['address'],
        adrId: json['adrId'],
        fullName: json['fullName'],
        landmark: json['landmark'],
        pinCode: json['pinCode']);
  }

  Map<String,dynamic> toMap(){
    return {
      'phone' : phone,
      'address': address,
      'adrId': adrId,
    'fullName': fullName,
    'landmark': landmark,
    'pinCode': pinCode
  };
}
}
