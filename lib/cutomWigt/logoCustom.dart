import 'package:flutter/material.dart';
class LogoCustom extends StatelessWidget {
  const LogoCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: EdgeInsets.only(top: 40),
      child: Container(
        height: MediaQuery.of(context).size.height*.2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(image: AssetImage('images/icons/main.png')),
            Positioned(bottom: 0, child: Text("fruits Market",style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 25,
              //color: kMainColors
            ),))
          ],
        ),
      ),
    );
  }
}