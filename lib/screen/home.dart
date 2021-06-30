import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/cutomWigt/textFild.dart';

class Home extends StatefulWidget {
  static String id ='HomePage';
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  String _email='',_password='';

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(

            padding: EdgeInsets.only(top: 40),
            child: Container(
              height: MediaQuery.of(context).size.height*.2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(image: AssetImage('images/icons/main2.png')),
                  Positioned(bottom: 0, child: Text("fruits Market",style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 25,
                    //color: kMainColors
                  ),))
                ],
              ),
            ),
          ),
          SizedBox(height:height* .1),
          CustomTextFied(
            onClik: (value){
              _email=value;
            },
            hint:"Enter your email",icon: Icons.email,),
          SizedBox(height:height* .07),

          CustomTextFied(
            onClik: (value){
              _password=value;
            },
            hint:"Enter your password",icon: Icons.lock,),
          SizedBox(height:height* .05),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: FlatButton(
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(20),
),
                color: kMainColors,

                onPressed: (){},
                child: Text("Login",
                style: TextStyle(
                  fontSize: 16,
                  color:Colors.black

                ),)),
          ),
          SizedBox(height:height* .05),

          Row(            mainAxisAlignment: MainAxisAlignment.center,

            children: [
            Text("Dont have account?",
            style: TextStyle(
              color: kMainColors,
              fontSize: 16,
            ),),
            SizedBox(width: 10,),
            Text("Login",
              style: TextStyle(

              fontSize: 16,))

          ],)
        ],
      ),
    );
  }
}


