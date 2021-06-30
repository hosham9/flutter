import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/provider/cartItems.dart';
import 'package:provider/provider.dart';

import 'cartscren.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity=1;
  int _cartn=0;
  @override
  Widget build(BuildContext context) {

    ProductEdit? products =
        ModalRoute.of(context)!.settings.arguments as ProductEdit?;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage(products!.pImage),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Container(
            height: MediaQuery.of(context).size.height * .1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [GestureDetector(
                  child: Icon(Icons.arrow_back_ios),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
                GestureDetector(child: Icon(Icons.shopping_cart),
                  onTap: (){
                  Navigator.pushNamed(context, CartScreen.id);
                  },
                )],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Column(
            children: [
              Opacity(
                child: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10,right: 20,left: 20,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products.pName,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          products.pDes,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          ' ${products.punit}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),

                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          '\$ ${products.pPrice}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Material(
                                color: kMainColors,
                                child: GestureDetector(
                                  onTap: (){_addion();},
                                    child: SizedBox(
                                      child: Icon(Icons.add),
                                  height: 28,
                                  width: 28,
                                )),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(_quantity.toString(),style: TextStyle(fontSize: 60),),
                            SizedBox(width: 10,),
                            ClipOval(
                              child: Material(
                                color: kMainColors,
                                child: GestureDetector(
                                  onTap: (){_subtract();},
                                    child: SizedBox(
                                      child: Icon(Icons.remove),
                                      height: 28,
                                      width: 28,
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                opacity: .5,
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .12,
                child: Builder(
                  builder:(context)=> RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10))),
                      color: kMainColors,
                      onPressed: () {

                       addTocart(context,products);



                      },
                      child: Text(
                        "Add to Card".toUpperCase(),
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  void _addion() {
    setState(() {
      _quantity++;
    });

  }

  void _subtract() {
    if(_quantity>1){
      setState(() {
        _quantity--;
      });

    }
  }

  void addTocart(context,products) async{
    CarItems cartitem = Provider.of<CarItems>(context,listen: false);
var productInCart=cartitem.products;
bool exist=false;
for(var productincart in productInCart){

  if(productincart.pName==products.pName)//item in cart befor
  {
exist=true;
  }
}
if(exist){//item in cart befor yes some message
  Scaffold.of(context).showSnackBar(SnackBar(

    content: Text('you have add to Cart before'),
  ));
}else{//item in cart befor no add item to cart
  products.pquantity=_quantity;
  cartitem.addProduct(products);
  _cartn=cartitem.products.length;
  Scaffold.of(context).showSnackBar(SnackBar(

    content: Text('Add to Cart'),
  ));

}
  }


}
