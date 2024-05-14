import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/buttons/default_button.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

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
                  const Icon(CupertinoIcons.barcode_viewfinder,
                      size: 200, color: Colors.white),
                  const SizedBox(height: 10),
                  kDeafultButton(
                    onPressed: () {
                      scanQR(context);
                    },
                    title: "Scan Barcode",
                  ),
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
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE,);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    print("ini barcode $barcodeScanRes");
    if (barcodeScanRes == "9780123456786") {
      Get.snackbar("Sukses", "Pesanan Sedang Dikirim", backgroundColor: Colors.white, colorText: Colors.orange.shade700);
    } else {
      Get.defaultDialog(
        title: "Informasi",
        titlePadding: const EdgeInsets.only(top: 15),
        contentPadding: const EdgeInsets.only(left: 15, right: 15),
        content: const Text(
            "Barcode yang di scan tidak valid, silahkan ulangi kembali"),
        cancel: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ya",
                style: kDefaultTextStyle(
                    color: GlobalVariable.mainColor)
            )
          ),           
        );
      return;
    }
  }
}