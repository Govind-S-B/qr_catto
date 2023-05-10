import 'package:flutter/material.dart';

class CatDisplayPage extends StatelessWidget {
  final String colorCat;
  const CatDisplayPage({super.key,required this.colorCat});

  int invertedColorHex(int color){
    return  ((color & 0xFF000000) | (~color & 0x00FFFFFF));
  }

  @override
  Widget build(BuildContext context) {

    int intColorCat = int.parse("FF$colorCat",radix:16);

    return Scaffold(
      backgroundColor: Color(intColorCat),
      body: Center(
        child: Image.asset("images/catto.gif",color: Color(invertedColorHex(intColorCat)).withOpacity(0.5),colorBlendMode: BlendMode.srcATop,),
      ),
    );
  }
}