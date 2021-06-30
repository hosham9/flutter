import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fruitsmarket/cutomWigt/logoCustom.dart';
import 'package:fruitsmarket/cutomWigt/textFild.dart';
import 'package:fruitsmarket/provider/modelHUD.dart';
import 'package:fruitsmarket/service/auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../component.dart';
class SinupScreen extends StatefulWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = "SinupScreen";
  late String _email,_password;

  @override
  _SinupScreenState createState() => _SinupScreenState();
}

class _SinupScreenState extends State<SinupScreen> {
  String meg='';
  String _email='',_password='',_name='';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _auth=Auth();

  get code => null;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;

    return  Scaffold(
        backgroundColor: kMainColors,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHUD>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                //LogoCustom(),
                SizedBox(height:height* .1),
                CustomTextFied(
                  onClik: (value){
                    _name =value;
                  }
                  ,
                hint:"Enter your name",icon: Icons.person,),
                SizedBox(height:height* .02),
                CustomTextFied(
                  onClik: (value){
                   _email=value;
                  },
                  hint:"Enter your email",icon: Icons.email,),
                SizedBox(height:height* .02),

                CustomTextFied(
                  onClik: (value){
                    _password=value;
                  },
                  hint:"Enter your password",icon: Icons.lock,),
                SizedBox(height:height* .05),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                    builder:(context)=> FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.black,

                        onPressed: ()async{
                          final modelHUD=Provider.of<ModelHUD>(context,listen:false)    ;
                          modelHUD.changisLoading(true);
                          if(_globalKey.currentState!.validate()){


                           _globalKey.currentState!.save();
                           try{
                             final authre=await _auth.sinUp(_email.trim(), _password.trim());
                             print(authre.user!.uid);
                             modelHUD.changisLoading(false);
                           } on FirebaseAuthException catch(e){

                             modelHUD.changisLoading(false);
                             Scaffold.of(context).showSnackBar(SnackBar(
                               content:

                                 Text(
                                    e.code)





                               ,));


                           }

                           print(_email);
                           print(_password);

                         }
                          modelHUD.changisLoading(false);

                        },
                        child: Text("Sin up",
                          style: TextStyle(
                              fontSize: 16,
                              color:Colors.white

                          ),)),
                  ),
                ),
                SizedBox(height:height* .05),

                Row(            mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text(" have account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, SinupScreen.id);
                      },
                      child: Text("Login",
                          style: TextStyle(

                            fontSize: 16,)),
                    )

                  ],)
              ],
            ),
          ),
        ),
      );
  }
}


