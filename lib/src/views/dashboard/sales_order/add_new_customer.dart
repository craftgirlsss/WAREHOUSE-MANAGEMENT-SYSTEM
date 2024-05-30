import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/buttons/default_button.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/customer_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/tracking/alamat_pengiriman.dart';
import 'package:warehouseapp/src/views/dashboard/tracking/alamat_tagihan.dart';

class AddNewCustomer extends StatefulWidget {
  final CustomerCategory? customerCategory;
  const AddNewCustomer({super.key, this.customerCategory});

  @override
  State<AddNewCustomer> createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  CustomerController customerController = Get.find();
  CustomerCategory? customerCategory = CustomerCategory.perusahaan;
  TextEditingController nama = TextEditingController();
  TextEditingController namaPerusahaan = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nomorTelepon = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController pajak = TextEditingController();
  String? customerCategoryString;

  @override
  void initState() {
    super.initState();
    customerCategory = widget.customerCategory;
  }

  @override
  void dispose() {
    nama.dispose();
    namaPerusahaan.dispose();
    email.dispose();
    alamat.dispose();
    nomorTelepon.dispose();
    pajak.dispose();
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
              title: Text("Add New Customer", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white60,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tipe Costumer", style: kDefaultTextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<CustomerCategory>(
                                contentPadding: const EdgeInsets.all(0),
                                title: Text('Perusahaan', style: kDefaultTextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                                groupValue: customerCategory,
                                value: CustomerCategory.perusahaan,
                                onChanged:(CustomerCategory? value) { 
                                  setState(() {
                                    customerCategory = value;
                                    customerCategoryString = 'Perusahaan';
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<CustomerCategory>(
                                contentPadding: const EdgeInsets.all(0),
                                title: Text('Individu', style: kDefaultTextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
                                groupValue: customerCategory,
                                value: CustomerCategory.individu,
                                onChanged:(CustomerCategory? value) { 
                                  setState(() {
                                    customerCategory = value;
                                    customerCategoryString = 'Individu';
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        TextField(
                          controller: nama,
                          decoration: const InputDecoration(
                            label: Text("Nama"),
                          ),
                        ),
                        customerCategoryString == null ? Container() : customerCategoryString == "Individu" ? Container() : TextField(
                          controller: namaPerusahaan,
                          decoration: const InputDecoration(
                            label: Text("Nama Perusahaan"),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          decoration: const InputDecoration(
                            label: Text("Email"),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.streetAddress,
                          controller: alamat,
                          decoration: const InputDecoration(
                            label: Text("Alamat"),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: nomorTelepon,
                          decoration: const InputDecoration(
                            label: Text("Nomor Telepon"),
                          ),
                        ),
                        TextField(
                          controller: pajak,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text("Pajak"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: kDeafultButton(
                          onPressed: (){
                            Get.to(() => const AlamatTagihan());
                          },
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          title: "Alamat Tagihan"
                        ) 
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: kDeafultButton(
                          onPressed: (){
                            Get.to(() => const AlamatPengiriman());
                          },
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          title: "Alamat Pengiriman"
                        ) 
                      ),
                    ],
                  ),
                  Obx(() => kDeafultButton(
                      onPressed: customerController.isLoading.value ? (){} : () async {
                        customerController.addCustomer(
                          tipeCostumer: customerCategoryString,
                          nama: nama.text,
                          namaPerusahaan: namaPerusahaan.text,
                          email: email.text,
                          phoneNumber: nomorTelepon.text,
                          npwp: pajak.text,     
                          alamat: alamat.text                     
                        ).then((value) {
                          Get.snackbar('Berhasil', "Berhasil menambah data customer", colorText: Colors.black, backgroundColor: Colors.white);
                          Future.delayed(const Duration(seconds: 1), (){
                            Navigator.pop(context);
                          });
                        });
                      },
                      title: "Submit"
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(() => customerController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}

enum CustomerCategory{
  individu,
  perusahaan
}