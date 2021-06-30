import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/models/orders.dart';
import 'package:fruitsmarket/service/stor.dart';

import '../component.dart';
import 'orderdetails.dart';
class OrdersScreen extends StatelessWidget {

  static String id='OrdersScreen';
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text("there is no orders"),
            );
          }else{
            List<Order> orders=[];
            for(var doc in snapshot.data!.docs){

              orders.add(Order(
                documentId: doc.id,
                totalPrice: doc.get(kTottalPrice),
               Address: doc.get(kAddress)
              ));
            }
            return ListView.builder(
              itemCount:orders.length ,
                itemBuilder: (context,index)
                {

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: (){

                        Navigator.pushNamed(context,Orderdetails.id,arguments: orders[index].documentId);


                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height*.2,
                        color: kSecondryColors,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('ToTall Price = \$ ${orders[index].totalPrice.toString()}'),
                            SizedBox(height: 10,),
                            Text('The address is ${orders[index].Address}')
                          ],),
                        ),
                      ),
                    ),
                  );
                }
            );

          }
        },
      )
    );
  }
}
