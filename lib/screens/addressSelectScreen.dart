import 'package:cloud_mart/providers/addressProvider.dart';
import 'package:cloud_mart/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressSelectScreen extends StatefulWidget {
  @override
  _AddressSelectScreenState createState() => _AddressSelectScreenState();
}

class _AddressSelectScreenState extends State<AddressSelectScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    final adrProvider = Provider.of<AddressProvider>(context, listen: false);
    adrProvider.loadAll(null);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final adrProvider = Provider.of<AddressProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Add Address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      onChanged: (String value) {
                        adrProvider.changeAddress = value;
                        adrProvider.changePinCode = 444505;
                      },
                      decoration: InputDecoration(
                        helperMaxLines: 2,
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                        // errorBorder:
                        //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                        // focusedErrorBorder:
                        //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                        // errorStyle: TextStyle(color: Colors.purple),
                      ),
                      maxLength: 40,

                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (String value) =>
                          adrProvider.changeLandmark = value,
                      decoration: InputDecoration(
                        labelText: 'Landmark',
                        border: OutlineInputBorder(),
                        // errorBorder:
                        //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                        // focusedErrorBorder:
                        //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                        // errorStyle: TextStyle(color: Colors.purple),
                      ),
                      maxLength: 30,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      onChanged: (String value) =>
                          adrProvider.changeFullName = value,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                        // errorBorder:
                        //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                        // focusedErrorBorder:
                        //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                        // errorStyle: TextStyle(color: Colors.purple),
                      ),
                      maxLength: 30,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      onChanged: (String value) =>
                          adrProvider.changePhone = int.parse(value),
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                        // errorBorder:
                        //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                        // focusedErrorBorder:
                        //     OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
                        // errorStyle: TextStyle(color: Colors.purple),
                      ),
                      maxLength: 10,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 10) {
                          return 'Enter Correct Phone';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Address Saved ')));
                            adrProvider.saveAddress();

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HomeScreen()));
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
