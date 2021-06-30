import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/service/stor.dart';
import 'package:fruitsmarket/component.dart';

import 'editProduct.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.LoadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductEdit> porducts = [];
            for (var doc in snapshot.data!.docs) {
              porducts.add(ProductEdit(
                  pid: doc.id,
                  punit: doc.get(kProductUint),
                  pName: doc.get(kProductName),
                  pDes: doc.get(kProductDescription),
                  pPrice: doc.get(kproductPrice),
                  pCat: doc.get(kProductCategory),
                  pImage: doc.get(kProductLocation)));
            }

            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.8),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details) {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx2 = MediaQuery.of(context).size.width - dx;
                        double dy2 = MediaQuery.of(context).size.width - dy;
                        showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items: [
                              // MyPopupMenuItem(),
                              PopupMenuItem(
                                child: InkWell(
                                  onTap: () {
                                    _store.deleteProduct(porducts[i].pid);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Delete"),
                                ),
                              ),
                              PopupMenuItem(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Navigator.pushNamed(
                                        context, EditiProduct.id,
                                        arguments: porducts[i]);

                                  },
                                  child: Text("Edit"),
                                ),
                              ),
                            ]);
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(porducts[i].pImage))),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        porducts[i].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ' ${porducts[i].pPrice} \$',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );

                });
          }else{
            return Text("Loading..");
          }
         return Text("no");

        },
      ),
    );
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  void getProducts() async {}
}
