import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scanner/scanbot_barcode_sdk.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/buttons/default_button.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'barcode_preview.dart';

class TrackingBarcode extends StatefulWidget {
  const TrackingBarcode({super.key});

  @override
  State<TrackingBarcode> createState() => _TrackingBarcodeState();
}

class _TrackingBarcodeState extends State<TrackingBarcode> {

  Future<bool> checkLicenseStatus(BuildContext context) async {
    var result = await ScanbotBarcodeSdk.getLicenseStatus();
    if (result.isLicenseValid) {
      return true;
    }
    // await showAlertDialog(
    //     context, 'Scanbot SDK trial period or (trial) license has expired.',
    //     title: 'Info');
    return false;
  }

  startBarcodeScanner({bool shouldSnapImage = false}) async {
    if (!await checkLicenseStatus(context)) {
      return;
    }
    final additionalParameters = BarcodeAdditionalParameters(
      minimumTextLength: 3,
      maximumTextLength: 45,
      minimum1DBarcodesQuietZone: 10,
      codeDensity: CodeDensity.HIGH,
    );
    var config = BarcodeScannerConfiguration(
      barcodeImageGenerationType: shouldSnapImage
          ? BarcodeImageGenerationType.VIDEO_FRAME
          : BarcodeImageGenerationType.NONE,
      topBarBackgroundColor: Colors.blueAccent,
      finderLineColor: Colors.red,
      cancelButtonTitle: "Cancel",
      finderTextHint:
          "Please align any supported barcode in the frame to scan it.",
      successBeepEnabled: true,

      // cameraZoomFactor: 1,
      additionalParameters: additionalParameters,
      barcodeFormats: barcodeFormatsRepository.selectedFormats.toList(),
      // see further customization configs ...
      orientationLockMode: OrientationLockMode.NONE,
      //useButtonsAllCaps: true,
    );

    try {
      var result = await ScanbotBarcodeSdk.startBarcodeScanner(config);

      if (result.operationResult == OperationResult.SUCCESS) {
        Future.delayed(Duration.zero).then((value) {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => BarcodesResultPreviewWidget(result)),
          );
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  
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
                      startBarcodeScanner();
                     },
                     title: "Scan Barcode",
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}


class BarcodeFormatsRepository {
  Set<BarcodeFormat> selectedFormats = getSelectableTypes().toSet();
  static List<BarcodeFormat> getSelectableTypes() {
    var values = PredefinedBarcodes.allBarcodeTypes();
    return values;
  }
}