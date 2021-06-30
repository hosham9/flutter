
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/service/stor.dart';
class Orderdetails extends StatelessWidget {

  static String id = 'Orderdetails';


  @override
  Widget build(BuildContext context) {
    Store _store = Store();
    Object? docId  = ModalRoute.of(context)!.settings.arguments ;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrdersDetails(docId),
          builder: (context,snapshot){
        if(snapshot.hasData){
          List<ProductOrder> products =[];
          for( var doc in snapshot.data!.docs){
            products.add(ProductOrder(
              pName: doc.get(kProductName),
              pCat: doc.get(kProductCategory),
             // pDes: doc.get(kProductDescription),
              pImage: doc.get(kProductLocation),
              pPrice: doc.get(kproductPrice),
              //punit: doc.get(kProductUint),
              pquantity:doc.get(kProductQuntity) ,

            ));


          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder:(context,index)=> Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      height: MediaQuery.of(context).size.height*.2,
                      color: kSecondryColors,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('product name  = \ ${products[index].pName}'),
                            SizedBox(height: 10,),
                            Text('Quantity: ${products[index].pquantity}'),
                            SizedBox(height: 10,),
                            Text('Catogry: ${products[index].pCat}'),
                            SizedBox(height: 10,),
                            Text('Price: ${products[index].pPrice}'),
                            SizedBox(height: 10,),

                          ],),
                      ),
                    ),
                  ),
                  itemCount: products.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                  Expanded(
                    child: ButtonTheme(
                      buttonColor: kMainColors,
                      child: RaisedButton(onPressed: (){},
                      child: Text("Confirm Order"),),
                    ),
                  ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: ButtonTheme(
                        buttonColor: kMainColors,
                        child: RaisedButton(onPressed: (){},
                          child: Text("Delete Order"),),
                      ),
                    ),

                ],),
              )
            ],
          );
        }else{
          return Center(child: Text("Loading Orders.."),);
        }
          }
      ),
    );
  }
}
