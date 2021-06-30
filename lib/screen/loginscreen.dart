import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/provider/adminMode.dart';
import 'package:fruitsmarket/provider/modelHUD.dart';
import 'dart:async';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/cutomWigt/textFild.dart';
import 'package:fruitsmarket/screen/sinupscreen.dart';
import 'package:fruitsmarket/service/auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import '../admin/adminpage.dart';
import 'home.dart';
import 'user/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  static String id = 'loginscreen';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool keepmeLogin = false;
  String _email = '', _password = '';
  bool isAdmin = false;
  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final String adminPassword = "admin1234";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColors,
      body: ProgressHUD(
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image(image: AssetImage('images/icons/main2.png')),
                      //SizedBox(height: 20,),
                      Positioned(
                          bottom: 0,
                          child: Text(
                            "fruits Market",
                            style: TextStyle(
                              fontFamily: 'Pacifico',
                              fontSize: 25,
                              //color: kMainColors
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * .07),
              CustomTextFied(
                onClik: (value) {
                  _email = value;
                },
                hint: "Enter your email",
                icon: Icons.email,
              ),
              SizedBox(height: height * .02),
              CustomTextFied(
                onClik: (value) {
                  _password = value;
                },
                hint: "Enter your password",
                icon: Icons.lock,
              ),
              //SizedBox(height: height * .05),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                          checkColor: kSecondryColors,
                          activeColor: kMainColors,
                          value: keepmeLogin,
                          onChanged: (value) {
                            setState(() {
                              keepmeLogin = value!;
                            });
                          }),
                    ),
                    Text(
                      "Remember Me",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.black,
                      onPressed: () async {
                        if (keepmeLogin == true) {
                          keepUserLogIn();
                        }
                        _validate(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                ),
              ),
              SizedBox(height: height * .05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Dont have account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SinupScreen.id);
                    },
                    child: Text("sinUp",
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  )
                ],
              ),
              SizedBox(height: height * .02),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      final adminMode =
                          Provider.of<AdminMode>(context, listen: false);
                      adminMode.changisAdmin(true);
                    },
                    child: Text("i\'m an admin",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin
                                ? kMainColors
                                : Colors.white)),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      final adminMode =
                          Provider.of<AdminMode>(context, listen: false);
                      adminMode.changisAdmin(false);
                    },
                    child: Text(
                      "i\'m an user",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Provider.of<AdminMode>(context).isAdmin
                              ? Colors.white
                              : kMainColors),
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) {
    final modelHUD = Provider.of<ModelHUD>(context, listen: false);
    final adminMode = Provider.of<AdminMode>(context, listen: false);
    modelHUD.changisLoading(true);
    if (_globalKey.currentState!.validate()) {
      _globalKey.currentState!.save();
      if (adminMode.isAdmin) {
        if (_password == adminPassword) {
          try {
            _auth.sinIn(_email, _password);
            Navigator.pushNamed(context, AdminPage.id);
          } on FirebaseAuthException catch (e) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.code),
            ));
          }
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("some thing is worrig"),
          ));
        }
      } else {
        try {
          _auth.sinIn(_email.trim(), _password.trim());

          Navigator.pushNamed(context, HomePage.id);
        } on FirebaseAuthException catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.code),
          ));
        }
      }
    }
    modelHUD.changisLoading(false);
  }

  void keepUserLogIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(kKeepmeLogin, keepmeLogin);
  }
}
