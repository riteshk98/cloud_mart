import 'package:cloud_mart/models/category.dart';
import 'package:cloud_mart/providers/categoryProvider.dart';
import 'package:cloud_mart/providers/productProvider.dart';

import 'package:cloud_mart/screens/productListScreen.dart';
import 'package:cloud_mart/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CategoryScreenWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final catProvider = Provider.of<CategoryProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Column(
      children: [
        SizedBox(
          height: 7,
        ),
        FutureBuilder<List<Category>>(
            future: catProvider.categories,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpansionTile(
                          trailing: Icon(Icons.add_box_outlined),
                          initiallyExpanded: false,
                          title: Text(snapshot.data[index].name),
                          children: <Widget>[
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                  (MediaQuery.of(context).size.height / 2.3),
                              padding: const EdgeInsets.all(10),
                              children: snapshot.data[index].subCategory
                                  .map((e) => InkWell(
                                        onTap: () async {
                                          await productProvider.getProducts(snapshot.data[index].categoryId,e.subCategoryId);
                                          Navigator.of(context).pushNamed(ProductListScreen.routeName,arguments: e.subCategoryName);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(width: 1)),
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              SvgPicture.network(
                                                e.subCategoryImage,
                                                height: 60,
                                                width: 60,
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(e.subCategoryName,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                  textAlign: TextAlign.center)
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            )
                          ]
                          // snapshot.data[index].subCategory
                          //     .map((e) => Text(e.subCategoryName))
                          //     .toList(),
                          // subtitle: Text(snapshot.data[0].categoryId),
                          );
                    });
              } else {
                return Loading();
              }
            })
      ],
    );
  }
}
//2 futures future builder
// FutureBuilder<List<dynamic>>(
// future: Future.wait([catProvider.categories,catProvider.categories]),
// builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
// if (snapshot.hasData) {
// return ListView.builder(scrollDirection: Axis.vertical,
// shrinkWrap: true,
// itemCount: snapshot.data[0].length,
// itemBuilder: (BuildContext context, int index) {
// return ExpansionTile(
// title: Text((snapshot.data[0] as List<Category>)[index].name),
// subtitle: Text((snapshot.data[0] as List<Category>)[index].subCategory[index].subCategoryName?? 'null') ,
// // subtitle: Text(snapshot.data[0].categoryId),
// );
// });
// } else {
// return CircularProgressIndicator();
// }
// })
