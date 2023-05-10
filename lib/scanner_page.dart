import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'cat_page.dart';

class ScannerPage extends StatelessWidget {
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(onDetect: (capture) {
            for(var barcode in capture.barcodes){
              try{
                Map decodedQr = jsonDecode(barcode.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) => CatDisplayPage(colorCat: decodedQr["color"],),));
              }
              catch(r){
                // will add stuff
              }
            }
          },)
        ],
      ),
    );
  }
}