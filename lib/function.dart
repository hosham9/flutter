
import 'models/product.dart';
List<ProductEdit> getItemByCatogry(String kFruits,List<ProductEdit> allproduct) {
  List<ProductEdit> porducts=[];
try{
  for(var product in allproduct) {
    if (product.pCat == kFruits) {
      porducts.add(product);
    }
  }
  }on Error catch(ex){
  print(ex);
}
  return porducts;
}