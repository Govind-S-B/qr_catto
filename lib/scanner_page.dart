import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_catto/qr_overlay.dart';

import 'cat_page.dart';

class ScannerPage extends StatelessWidget {
  ScannerPage({super.key});

  final MobileScannerController cameraConroller = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraConroller,
            onDetect: (capture) {
            for(var barcode in capture.barcodes){
              try{
                Map decodedQr = jsonDecode(barcode.rawValue!.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) => CatDisplayPage(colorCat: decodedQr["color"],),));
                debugPrint("yo");
                cameraConroller.stop();
              }
              catch(r){
                // will add stuff
              }
            }
          },),
          QRScannerOverlay(imagePath: "images/test.jpg")
        ],
      ),
    );
  }
}