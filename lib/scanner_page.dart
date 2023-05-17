import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_catto/qr_overlay.dart';
import 'cat_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              for (var barcode in capture.barcodes.toSet()) {
                try {
                  Map decodedQr = jsonDecode(barcode.rawValue!.toString());
                  assert(decodedQr["color"] != null);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatDisplayPage(
                          colorCat: decodedQr["color"],
                        ),
                      ));
                  cameraConroller.stop();
                } catch (r) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xffc72c41),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 48,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                          "Something went wrong with the qr code",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )),
                                      Text("$r",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Positioned(
                          bottom: 0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20)),
                            child: SizedBox(
                                width: 48,
                                height: 40,
                                child: SvgPicture.asset(
                                  "images/bubbles.svg",
                                  color: const Color(0xff801336),
                                )),
                          ),
                        ),
                        Positioned(
                            top: -20,
                            child: SvgPicture.asset(
                              "images/fail.svg",
                              width: 48,
                              height: 40,
                              color: const Color(0xff801336),
                            ))
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ));
                }
              }
            },
          ),
          QRScannerOverlay(
            imagePath: "images/test.jpg",
          )
        ],
      ),
    );
  }
}
