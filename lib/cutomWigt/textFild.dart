import 'package:flutter/material.dart';

import '../component.dart';
class CustomTextFied extends StatelessWidget {
  final String hint;
  final IconData icon;
  final   onClik;

  String _errorMessage(String  hit){
switch(hit){
  case 'Enter your name':return 'Enter your name';
  case 'Enter your email':return 'Enter your email';
  case 'Enter your password':return 'Enter your password';
}
return '';
  }
  CustomTextFied({ required this.onClik,required this.hint,required this.icon}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(

        obscureText: hint=="Enter your password"?true:false,
        validator: (value){
          if (value!.isEmpty){
            return _errorMessage(hint);
          }

        },

        onSaved: onClik,
        cursorColor: kMainColors,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon,color: kMainColors),
            filled: true,
            fillColor: Colors.white,

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: kMainColors
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: kMainColors
                )
            ),
         border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(20),
             borderSide: BorderSide(
                 color: kMainColors
             )
         )
        ),
      ),
    );
  }
}
///////////////////

class CustomTextFiedin extends StatelessWidget {
  final String hint;
  final IconData icon;
  final   onClik;
  final String inl;

  String _errorMessage(String  hit){
    switch(hit){
      case 'Enter your name':return 'Enter your name';
      case 'Enter your email':return 'Enter your email';
      case 'Enter your password':return 'Enter your password';
    }
    return '';
  }
  CustomTextFiedin({ required this.onClik,required this.hint,required this.icon,required this.inl}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
initialValue: inl,
        obscureText: hint=="Enter your password"?true:false,
        validator: (value){
          if (value!.isEmpty){
            return _errorMessage(hint);
          }

        },

        onSaved: onClik,
        cursorColor: kMainColors,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon,color: kMainColors),
            filled: true,
            fillColor: Colors.white,

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: kMainColors
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: kMainColors
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: kMainColors
                )
            )
        ),
      ),
    );
  }
}
/////////////
class CuTextFied extends StatelessWidget {
  final String hint;


  String _errorMessage(String  hit){
    switch(hit){
      case 'Enter your name':return 'Enter your name';
      case 'Enter your email':return 'Enter your email';
      case 'Enter your password':return 'Enter your password';
    }
    return '';
  }
  CuTextFied({ required this.hint}) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        obscureText: hint=="Enter your password"?true:false,
        validator: (value){
          if (value!.isEmpty){
            return _errorMessage(hint);
          }

        },


        cursorColor: kMainColors,
        decoration: InputDecoration(
            hintText: hint,

            filled: true,
            fillColor: Colors.white,

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: kMainColors
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: kMainColors
                )
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: kMainColors
                )
            )
        ),
      ),
    );
  }
}