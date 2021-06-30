import 'package:flutter/cupertino.dart';
class AdminMode extends ChangeNotifier{
  bool isAdmin = false;
  changisAdmin(bool value){
    isAdmin=value;
    notifyListeners();
  }
}