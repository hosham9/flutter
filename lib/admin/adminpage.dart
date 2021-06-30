import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/admin/orderScreen.dart';
import 'dart:async';

import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/cutomWigt/textFild.dart';

import 'addProduct.dart';
import 'managerProduct.dart';

class AdminPage extends StatefulWidget {
  static String id ='AdminPage';
  @override
  _AdminPageState createState() => _AdminPageState();

 }

class _AdminPageState extends State<AdminPage> {
  String _email='',_password='';

  @override

  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity,),
          RaisedButton(
              onPressed: ()
              {
              Navigator.pushNamed(context, AddProduct.id);
              },
            child: Text("Add Product"),

              ),
          RaisedButton(
              onPressed: ()
              {
Navigator.pushNamed(context, ManageProduct.id);
              },
            child: Text("Edit Product"),

          ),
          RaisedButton(
              onPressed: ()
              {Navigator.pushNamed(context, OrdersScreen.id);
              },

            child: Text("View Orders"),

          )

      ],),
    );
  }
}


