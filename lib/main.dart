import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruitsmarket/admin/addProduct.dart';
import 'package:fruitsmarket/admin/editProduct.dart';
import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/provider/adminMode.dart';
import 'package:fruitsmarket/provider/cartItems.dart';
import 'package:fruitsmarket/provider/modelHUD.dart';
import 'package:fruitsmarket/admin/adminpage.dart';
import 'package:fruitsmarket/screen/user/cartscren.dart';
import 'package:fruitsmarket/screen/user/homePage.dart';
import 'package:fruitsmarket/screen/sinupscreen.dart';
import 'package:fruitsmarket/screen/user/productinfo.dart';
import 'package:fruitsmarket/service/stor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screen/loginscreen.dart';
import './screen/home.dart';
import './screen/sinupscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'admin/adminpage.dart';
import 'admin/addProduct.dart';
import 'admin/managerProduct.dart';
import 'admin/editProduct.dart';
import 'admin/orderScreen.dart';
import 'admin/orderdetails.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
 bool isUserLogin=false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
        builder:(context,snapshot){
        if(!snapshot.hasData){
          return MaterialApp(debugShowCheckedModeBanner: false,home: Scaffold(body: Center(child: Text('Loading..'),),),);
        }else{
          isUserLogin=snapshot.data!.getBool(kKeepmeLogin) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHUD>(create: (context) => ModelHUD()),
              ChangeNotifierProvider<AdminMode>(create: (context) => AdminMode()),
              ChangeNotifierProvider<CarItems>(create: (context) => CarItems()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              //بدايه المشروع
              title: "Mobitech",
              home: Login(),
              //theme: ThemeData(fontFamily: 'Pacifico'),//اسم التطبيق يظهر هاتف المستخدم
              initialRoute:isUserLogin?HomePage.id: Login.id,
              routes: {
                Login.id: (context) => Login(),
                SinupScreen.id: (context) => SinupScreen(),
                Home.id: (context) => Home(),
                AdminPage.id: (context) => AdminPage(),
                AddProduct.id: (context) => AddProduct(),
                ManageProduct.id: (context) => ManageProduct(),
                EditiProduct.id: (context) => EditiProduct(),
                HomePage.id: (context) => HomePage(),
                ProductInfo.id: (context) => ProductInfo(),
                CartScreen.id: (context) => CartScreen(),
                OrdersScreen.id: (context) => OrdersScreen(),
                Orderdetails.id: (context) => Orderdetails(),
              },
              //نهايه المشروع
            ),
          );
        }

        }
    );
  }
}
