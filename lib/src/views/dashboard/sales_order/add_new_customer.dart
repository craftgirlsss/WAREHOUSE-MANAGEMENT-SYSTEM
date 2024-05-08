import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/buttons/default_button.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
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
  CustomerCategory? customerCategory = CustomerCategory.perusahaan;
  TextEditingController nama = TextEditingController();
  TextEditingController namaPerusahaan = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController nomorTelepon = TextEditingController();
  TextEditingController pajak = TextEditingController();

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
                        TextField(
                          controller: namaPerusahaan,
                          decoration: const InputDecoration(
                            label: Text("Nama Perusahaan"),
                          ),
                        ),
                        TextField(
                          controller: email,
                          decoration: const InputDecoration(
                            label: Text("Email"),
                          ),
                        ),
                        TextField(
                          controller: nomorTelepon,
                          decoration: const InputDecoration(
                            label: Text("Nomor Telepon"),
                          ),
                        ),
                        TextField(
                          controller: pajak,
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum CustomerCategory{
  individu,
  perusahaan
}