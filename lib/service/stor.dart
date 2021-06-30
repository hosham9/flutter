import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/component.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  deleteProduct(documentId){
    _firestore.collection(KProductsCollection).doc(documentId).delete();
  }
  editProduct(data,documentId){
    _firestore.collection(KProductsCollection).doc(documentId).update(data);
  }
  addProduct(Product product) {
    _firestore.collection(KProductsCollection).add(
        {

          kProductUint:product.punit,
          kProductName:product.pName,
          kproductPrice:product.pPrice,
          kProductDescription:product.pDes,
          kProductCategory:product.pCat,
          kProductLocation:product.pImage,

        });
  }
  storeOrder(data,List<ProductEdit> product){
   var order= _firestore.collection(kOrders).doc();
   order.set(data);
   for(var product in product)
   order.collection(kOrdersDetails).doc().set(
     {
       kProductName:product.pName,
       kproductPrice:product.pPrice,
       kProductQuntity:product.pquantity,
       kProductLocation:product.pImage,
       kProductCategory:product.pCat,
     }
   );
  }

  Stream<QuerySnapshot> LoadProduct() {
    return _firestore.collection(KProductsCollection).snapshots();
  }
  Stream<QuerySnapshot> loadOrders(){
    return _firestore.collection(kOrders).snapshots();
  }
  Stream<QuerySnapshot> loadOrdersDetails(docId){
    return _firestore.collection(kOrders).doc(docId).collection(kOrdersDetails).snapshots();
  }
   LoadProductid(data) {
    return _firestore.collection(KProductsCollection).doc(data);
  }



  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
 CollectionReference _firestore =FirebaseFirestore.instance.collection(KProductsCollection);

  @override
  Widget build(BuildContext context) {
    return Scaffold();


}


}
