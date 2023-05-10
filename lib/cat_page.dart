import 'package:flutter/material.dart';

class CatDisplayPage extends StatelessWidget {
  final String colorCat;
  const CatDisplayPage({super.key,required this.colorCat});

  @override
  Widget build(BuildContext context) {

    int intColorCat = int.parse("FF$colorCat",radix:16);

    return Scaffold(
      backgroundColor: Color(intColorCat),
      body: Center(
        child: Image.asset("images/catto.gif"),
      ),
    );
  }
}