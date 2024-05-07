import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/buttons/default_button.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/tracking/alamat_pengiriman.dart';

class TrackingBarcode extends StatefulWidget {
  const TrackingBarcode({super.key});

  @override
  State<TrackingBarcode> createState() => _TrackingBarcodeState();
}

class _TrackingBarcodeState extends State<TrackingBarcode> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(CupertinoIcons.barcode_viewfinder, size: 200, color: Colors.white),
                  const SizedBox(height: 10),
                  kDeafultButton(
                     onPressed: (){
                      scanQR(context);
                     },
                     title: "Scan Barcode",
                  ),
                  // kDeafultButton(
                  //    onPressed: (){
                  //     Get.to(() => const AlamatPengiriman());
                  //    },
                  //    title: "Alamat Pengiriman",
                  // ),
                  // kDeafultButton(
                  //    onPressed: (){
                  //     Get.to(() => const AlamatTagihan());
                  //    },
                  //    title: "Alamat Tagihan",
                  // ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> scanQR(context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    if (barcodeScanRes.isNotEmpty) {
      Get.to(() => const AlamatPengiriman());
    } else {
      return;
    }
  }
}