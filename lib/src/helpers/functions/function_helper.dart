import 'package:flutter/material.dart';
import 'package:get/get.dart';

void saveAddingStock({String? contactName, String? dateTime, String? notes, String? items, Function()? onOK}){
  if(contactName != '' && dateTime != '' && notes != '' && items != ''){
    Get.defaultDialog(
      title: "Apakah anda yakin menambah kontak dan disimpan dalam database?",
      actions: [
        TextButton(onPressed: onOK, child: const Text("Ya")),
        TextButton(onPressed: (){
          Get.back();
        }, child: const Text("Tidak")),
      ]
    );
  }else{
    Get.snackbar("Failed", "Gagal menyimpan data", backgroundColor: Colors.red, colorText: Colors.white);
  }
}