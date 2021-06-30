
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/cutomWigt/textFild.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/service/stor.dart';
import 'package:fruitsmarket/component.dart';

import 'managerProduct.dart';

class EditiProduct extends StatelessWidget {
static  String id ='EditiProduct';


String _name='',_price='',_description='',_category='',_imageLocation='',_unit='';
final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
final _store=Store();
final FirebaseFirestore _firestore =FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
     ProductEdit? products = ModalRoute.of(context)!.settings.arguments as ProductEdit?;
     CollectionReference  data =_firestore.collection(KProductsCollection);
getdata()async{
  String id=products.toString();
  DocumentReference doc=_firestore.doc(id);
  await doc.get().then((value) {
   print(value.toString()) ;
  }
  );
}
     double height=MediaQuery.of(context).size.height;
    return Form(
      key: _globalKey,
      child: Scaffold(
        body: ListView(
          children: [
            Column(children: [


              SizedBox(height: height*.09,),
              CustomTextFiedin(
                onClik: (value){
                  _name=value;
                },

                hint: 'Product Name',
                icon: Icons.adb,
                inl: products!.pName,
              ),
              SizedBox(height: height*.02,),
              CustomTextFiedin(
                onClik: (value){
                  _price=value;
                },

                hint: 'Product Price',
                icon: Icons.adb,
                inl: products.pPrice,

              ),
              SizedBox(height: height*.02,),
              CustomTextFiedin(
                onClik: (value){
                  _description=value;
                },

                hint: 'Product Description',
                icon: Icons.adb,
                inl: products.pDes,

              ),
              SizedBox(height: height*.02,),
              CustomTextFiedin(
                onClik: (value){
                  _category=value;
                },

                hint: 'Product Category',
                icon: Icons.adb,
                inl: products.pCat,

              ),
              SizedBox(height: height*.02,),
              CustomTextFiedin(
                onClik: (value){
                  _unit=value;
                },

                hint: 'Product unit',
                icon: Icons.adb,
                inl: products.punit,

              ),
              SizedBox(height: height*.02,),
              CustomTextFiedin(
                onClik: (value){
                  _imageLocation=value;
                },
                hint: 'Product Location',
                icon: Icons.adb,
                inl: products.pImage,

              ),
              SizedBox(height: height*.03,),


              RaisedButton(
                onPressed: (){

                  print("4444444444444444444444444");
                  print(products.toString());
                   getdata();


                  if(_globalKey.currentState!.validate()){
                    _globalKey.currentState!.save();
_store.editProduct(({
  kProductName: _name,
  kproductPrice:_price,
  kProductDescription:_description,
  kProductCategory:_category,
  kProductLocation:_imageLocation,
  kProductUint:_unit

})

, products!.pid);
                    Navigator.pushNamed(context, ManageProduct.id);
                  }
                },
                child: Text("Edit Product"),
              )

            ],),
          ],
        ),
      ),
    );
  }

}



