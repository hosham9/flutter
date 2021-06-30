import 'package:flutter/cupertino.dart';
import 'package:fruitsmarket/models/product.dart';

class CarItems extends ChangeNotifier{
  List<ProductEdit> products =[];
  addProduct(ProductEdit product){
    products.add(product);
    notifyListeners();
  }
  deleteProduct(ProductEdit product){
    products.remove(product);
    notifyListeners();
  }
}