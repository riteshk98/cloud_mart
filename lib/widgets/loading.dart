import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.height-220,
      child: Center(
        child: SpinKitChasingDots(
          size: 50,
          color: Colors.brown,
        ),
      ),
    );
  }
}
