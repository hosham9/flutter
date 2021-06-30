import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/provider/cartItems.dart';
import 'package:fruitsmarket/screen/user/homePage.dart';
import 'package:fruitsmarket/screen/user/productinfo.dart';
import 'package:fruitsmarket/service/stor.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    final double heib = AppBar().preferredSize.height;
    final double statushei = MediaQuery.of(context).padding.top;
    List<ProductEdit> product =
        Provider.of<CarItems>(context).products.cast<ProductEdit>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onTap: () {
            // Navigator.pushNamed(context,HomePage.id);
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          LayoutBuilder(builder: (context, constrains) {
            if (product.isNotEmpty) {
              return Container(
                height: screenheight - statushei - heib - (screenheight * .08),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15),
                        child: GestureDetector(
                          onTapUp: (details) {
                            showCustomMenu(details, context, product[index]);
                          },
                          child: Container(
                              height: screenheight * .15,
                              color: kSecondryColors,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: screenheight * (.15 / 2),
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        AssetImage(product[index].pImage),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                product[index].pName,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  '\$ ${product[index].pPrice}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Text(product[index]
                                                .pquantity
                                                .toString()),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Container(
                  height:
                      screenheight - (screenheight * .08) - statushei - heib,
                  child: Center(child: Text("Cart is Empity")));
            }
          }),
          Builder(
              builder: (context) => ButtonTheme(
                    minWidth: screenwidth,
                    height: screenheight * .08,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: RaisedButton(
                      onPressed: () {
                        showOrderDailog(product, context);
                      },
                      child: Text("order".toUpperCase()),
                      color: kMainColors,
                    ),
                  ))
        ],
      ),
    );
  }

  void showCustomMenu(details, context, porduct) async {
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
                Navigator.pop(context);
                Provider.of<CarItems>(context, listen: false)
                    .deleteProduct(porduct);
              },
              child: Text("Delete"),
            ),
          ),
          PopupMenuItem(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                Provider.of<CarItems>(context, listen: false)
                    .deleteProduct(porduct);
                Navigator.pushNamed(context, ProductInfo.id,
                    arguments: porduct);
                //
              },
              child: Text("Edit"),
            ),
          ),
        ]);
  }

  void showOrderDailog(List<ProductEdit> products, context) async {
    var price = getItemsPrice(products);
    var address;
    AlertDialog alertDialog = AlertDialog(
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: 'enter your address'),
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Store _store = Store();
            try {
              _store.storeOrder({
                kTottalPrice: price,
                kAddress: address,
              }, products);
              Scaffold.of(context).showSnackBar(SnackBar(

                content: Text('order Successfully'),
              ));
              Navigator.pop(context);
            } catch (ex) {

              print(ex);
            }
          },
          child: Text("Confirm"),
        )
      ],
      title: Text("Totall price = \$ $price"),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getItemsPrice(List<ProductEdit> products) {
    var price = 0;
    for (var product in products) {
      price += product.pquantity * int.parse(product.pPrice);
    }
    return price;
  }
}
