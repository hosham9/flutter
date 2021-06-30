import 'package:flutter/material.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/screen/user/productinfo.dart';

import '../function.dart';
Widget productView(String item,List<ProductEdit>allProduct) {
  List<ProductEdit> porducts;
  porducts= getItemByCatogry(item,allProduct);
  return GridView.builder(
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8),

      itemCount: porducts.length,
      itemBuilder: (context,i){

        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: GestureDetector(
onTap: (){Navigator.pushNamed(context, ProductInfo.id,arguments: porducts[i]);},
            child: Stack(
              children: [
                Positioned.fill(child: Image(fit: BoxFit.fill,
                    image: AssetImage(porducts[i].pImage)
                )
                ),
                Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: .6,
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(porducts[i].pName,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(' ${porducts[i].pPrice} \$',style: TextStyle(fontWeight: FontWeight.bold),),
                          ],),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
        // Text(porducts[i].pName);
        // Text(snapshot.data!.docs[i].get(kProductName));
      });
}