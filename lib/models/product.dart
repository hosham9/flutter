class Product{
  String pName='';
  String pPrice='';
  String pDes='';
  String pCat='';
  String pImage='';
  String punit='';
  int pquantity=1;

  Product({required this.pName,required this.pPrice,required this.pDes,required this.pCat,required this.pImage,required this.punit});

}
class ProductEdit{
  String pName='';
  String pPrice='';
  String pDes='';
  String pCat='';
  String pImage='';
  String pid='';
  String punit='';
  int pquantity=1;
  ProductEdit({required this.punit,required this.pid,required this.pName,required this.pPrice,required this.pDes,required this.pCat,required this.pImage});

}
class ProductOrder{
  String pName='';
  String pPrice='';
String pCat='';

  String pImage='';

  int pquantity=1;
  ProductOrder({required this.pquantity,required this.pName,required this.pPrice,required this.pImage,required this.pCat});

}