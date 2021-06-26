// import 'package:cloud_mart/providers/addressProvider.dart';
// import 'package:cloud_mart/providers/cartProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// class ExtraScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<AddressProvider>(context,listen: false);
//     return Scaffold(body: FutureBuilder(future: cartProvider.getCart(),builder: (context,snapshot){
//       if(snapshot.hasData){
//         return Text('data');
//       }
//       else{
//         return Center(child: CircularProgressIndicator(),);
//       }
//     },),);
//   }
// }
