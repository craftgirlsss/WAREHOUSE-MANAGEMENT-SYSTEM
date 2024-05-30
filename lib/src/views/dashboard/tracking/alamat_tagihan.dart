import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/customer_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class AlamatTagihan extends StatefulWidget {
  const AlamatTagihan({super.key});

  @override
  State<AlamatTagihan> createState() => _AlamatTagihanState();
}

class _AlamatTagihanState extends State<AlamatTagihan> {
  CustomerController customerController = Get.find();
  TextEditingController alamatLengkap = TextEditingController();
  TextEditingController kodePos = TextEditingController();

  @override
  void dispose() {
    alamatLengkap.dispose();
    kodePos.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.indigo.shade800,
              title: Text("Alamat Tagihan", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 25,
                color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
                actions: [
                  Obx(() => TextButton(
                    onPressed: customerController.isLoading.value ? (){} : (){
                      customerController.alamatTagihan.value = alamatLengkap.text;
                      customerController.kode_pos_alamat_tagihan.value = kodePos.text;
                      Get.snackbar('Berhasil', "Berhasil menyimpan data tagihan", colorText: Colors.black, backgroundColor: Colors.white);
                      Future.delayed(const Duration(seconds: 1), (){
                        Navigator.pop(context);
                      });
                    }, child: Text("Save", style: kDefaultTextStyle(color: Colors.white),)))
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white60,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.streetAddress,
                          controller: alamatLengkap,
                          decoration: const InputDecoration(
                            label: Text("Alamat Lengkap"),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          controller: kodePos,
                          decoration: const InputDecoration(
                            label: Text("Kode Pos"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}