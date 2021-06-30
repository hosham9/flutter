import 'package:flutter/cupertino.dart';
class ModelHUD extends ChangeNotifier{
bool isLoading = false;
changisLoading(bool value){
  isLoading=value;
  notifyListeners();
}
}