import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class AddCategooryPage extends StatefulWidget {
  const AddCategooryPage({super.key});

  @override
  State<AddCategooryPage> createState() => _AddCategooryPageState();
}

class _AddCategooryPageState extends State<AddCategooryPage> {
  TextEditingController kodeBuku = TextEditingController();
  TextEditingController judulBuku = TextEditingController();
  ProductControllers productControllers = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    kodeBuku.dispose();
    judulBuku.dispose();
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
            appBar: kDefaultAppBar(context, title: "Form Kategori", actions: [
              Obx(() => TextButton(
                onPressed: productControllers.isLoading.value ? () {} : () async {
                  if(kodeBuku.text == '' || judulBuku.text == ''){
                    Get.snackbar("Gagal", "Mohon isi terlebih dahulu field yang tersedia", backgroundColor: Colors.white);
                  }else{
                    if(await productControllers.addCategory(
                      judul: judulBuku.text,
                      kodeBuku: kodeBuku.text
                    )){
                      Get.snackbar("Berhasil", "Berhasil menambah kategori", backgroundColor: Colors.white);
                      await productControllers.getCategoryItem();
                      Navigator.pop(context);
                    }else{
                      Get.snackbar("Gagal", "Gagal menambah kategori", backgroundColor: Colors.white);
                    }
                  }
                }, child: Text("Save", style: kDefaultTextStyle(color: Colors.white, fontSize: 16),)),
              )
            ], withAction: true),
            body: ListView(
              padding: GlobalVariable.defaultPadding,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,                
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        readOnly: true,
                        controller: kodeBuku,
                        decoration: InputDecoration(
                          label: Text("Kode Buku", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                          suffixIcon: IconButton(
                            tooltip: "Generate Kode",
                            onPressed: () async {
                              String randomString = getRandomString(2);
                              setState(() {
                                kodeBuku.text = "F-$randomString";
                              });
                            },
                            icon: const Icon(CupertinoIcons.arrow_2_circlepath),),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: judulBuku,
                        decoration: InputDecoration(
                          label: Text("Nama Kategori", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() => productControllers.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()
          ),
      ],
    );
  }

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(
    Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
    )
  );
}