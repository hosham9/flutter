import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruitsmarket/admin/editProduct.dart';
import 'package:fruitsmarket/component.dart';
import 'package:fruitsmarket/cutomWigt/poductView.dart';
import 'package:fruitsmarket/models/product.dart';
import 'package:fruitsmarket/screen/user/cartscren.dart';
import 'package:fruitsmarket/screen/user/productinfo.dart';
import 'package:fruitsmarket/service/auth.dart';
import 'package:fruitsmarket/service/stor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component.dart';
import '../../component.dart';
import '../../function.dart';
import '../loginscreen.dart';
class HomePage extends StatefulWidget {
 static String id ='HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store=Store();
  List<ProductEdit> _product=[];

  final _auth = Auth();
  //FirebaseUser _loggedUser;
  int _tabBarindex=0;
  int _bottomindex=0;
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _bottomindex,
              fixedColor: kMainColors,
              onTap: (value)async{
                if(value==2){
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.clear();
                await  _auth.SingOut();
                Navigator.popAndPushNamed(context,Login.id);
                }
                setState(() {

                  _bottomindex=value;

                });
              },
              items: [

                BottomNavigationBarItem(
                    label: 'hoshsm', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'hoshsm', icon: Icon(Icons.person)),
                BottomNavigationBarItem(
                    label: 'Sign Out', icon: Icon(Icons.close))
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,

              bottom: TabBar(
                indicatorColor: kMainColors,
               onTap: (value){
                 setState(() {
                   _tabBarindex=value;
                 });

               },
                tabs: [




                Text('اعشاب',style: TextStyle(color:_tabBarindex==0?Colors.black:UnActiveColors,fontSize:_tabBarindex==0?16:null ),),
                Text('خضروات',style:TextStyle(color:_tabBarindex==1?Colors.black:UnActiveColors,fontSize:_tabBarindex==1?16:null )),
                Text(' مجففة',style: TextStyle(color:_tabBarindex==2?Colors.black:UnActiveColors,fontSize:_tabBarindex==2?16:null )),
                Text('فاكه',style:TextStyle(color:_tabBarindex==3?Colors.black:UnActiveColors,fontSize:_tabBarindex==3?16:null )),
              ],),

            ),
            body: TabBarView(children: [


              productView(kSpices,_product),
              productView(kVegetables,_product),
              productView(kJuice,_product),
              itemsView()   ,


            ],),
          )),
      Material(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Container(

            height: MediaQuery.of(context).size.height*.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Discover".toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              GestureDetector(child: Icon(Icons.shopping_cart),onTap: (){
                Navigator.pushNamed(context, CartScreen.id);
              },)
            ],),),
        ),
      )
      
    ],
    );
  }

   Widget itemsView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.LoadProduct(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List<ProductEdit>porducts=[];
          for(var doc in snapshot.data!.docs){
          //  if(doc.get(kProductCategory)==kFruits){
            porducts.add(ProductEdit(
                pid: doc.id,

                punit: doc.get(kProductUint),

                pName: doc.get(kProductName),
                pDes: doc.get(kProductDescription),
                pPrice: doc.get(kproductPrice),
                pCat: doc.get(kProductCategory),
                pImage: doc.get(kProductLocation)

            ));
         }
_product=[...porducts] ;
        porducts.clear();

          porducts= getItemByCatogry(kFruits,_product);
         
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

        }else{
          return Center(child: Text("Loading...."),);
        }

        return Text("no") ;

      },

    );

  }




}
