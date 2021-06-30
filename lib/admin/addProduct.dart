import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/cutomWigt/textFild.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/service/stor.dart';

class AddProduct extends StatelessWidget {
  static String id = "AddProduct";
  String _name='',_price='',_description='',_category='',_imageLocation='',_unit='';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store=Store();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Form(
      key: _globalKey,
      child: Scaffold(
        body: ListView(
          children: [
            Column(children: [
              SizedBox(height: height*.09,),
              CustomTextFied(
                onClik: (value){
                  _name=value;
                },

                hint: 'Product Name',
                icon: Icons.adb,
              ),
              SizedBox(height: height*.02,),
              CustomTextFied(
                onClik: (value){
                  _price=value;
                },

                hint: 'Product Price',
                icon: Icons.adb,

              ),
              SizedBox(height: height*.02,),
              CustomTextFied(
                onClik: (value){
                  _description=value;
                },

                hint: 'Product Description',
                icon: Icons.adb,

              ),
              SizedBox(height: height*.02,),
              CustomTextFied(
                onClik: (value){
                  _category=value;
                },

                hint: 'Product Category',
                icon: Icons.adb,

              ),
              SizedBox(height: height*.02,),
              CustomTextFied(
                onClik: (value){
                  _unit=value;
                },

                hint: 'Product Unit',
                icon: Icons.adb,

              ),
              SizedBox(height: height*.02,),
              CustomTextFied(
                onClik: (value){
                  _imageLocation=value;
                },
                hint: 'Product Location',
                icon: Icons.adb,

              ),
              SizedBox(height: height*.03,),
              RaisedButton(
                onPressed: (){
                  if(_globalKey.currentState!.validate()){
                    _globalKey.currentState!.save();
                    _store.addProduct(Product(

                      punit:_unit,
                      pName: _name,
                      pPrice: _price,
                      pCat: _category,
                      pDes: _description,
                      pImage: _imageLocation,

                    ));
                  }
                },
                child: Text("add Product"),
              )

            ],),
          ],
        ),
      ),
    );
  }
}
