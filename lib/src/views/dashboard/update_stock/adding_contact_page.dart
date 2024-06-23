import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/account_controller.dart';
import 'package:warehouseapp/src/controllers/customer_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class AddingContactPage extends StatefulWidget {
  const AddingContactPage({super.key});

  @override
  State<AddingContactPage> createState() => _AddingContactPageState();
}

class _AddingContactPageState extends State<AddingContactPage> {
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  CustomerController customerController = Get.put(CustomerController());
  AccountController accountController = Get.find();
  String? datePicked;
  Dataperson? dataperson = Dataperson.customer;
  PhoneContact? phoneContact;
  String? nameContact;

  @override
  void dispose() {
    contactNameController.dispose();
    contactNumberController.dispose();
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
            appBar: kDefaultAppBar(context, title: "Create Contact", actions: [
              Obx(() => TextButton(
                onPressed: customerController.isLoading.value ? (){} : () async {
                  if(contactNameController.text == '' || contactNumberController.text == ''){
                    Get.snackbar('Gagal', "Mohon isi semua field", backgroundColor: Colors.white);
                  }else{
                    if(dataperson == Dataperson.customer){
                      if(await customerController.addCustomer(nama: contactNameController.text, phoneNumber: contactNumberController.text)){
                        Get.snackbar('Berhasil', "Berhasil menambah kontak customer", backgroundColor: Colors.white);
                        Future.delayed(Duration.zero, ()async{
                          await accountController.getPersonContact();
                          Navigator.pop(context);
                        });
                      }else{
                        Get.snackbar('Gagal', "Gagal menambah kontak customer", backgroundColor: Colors.white);
                      }
                    }else if(dataperson == Dataperson.vendor){
                      if(await customerController.addVendor(
                        nama: contactNameController.text, phone: contactNameController.text)){
                        Get.snackbar('Berhsil', "Berhasil menambah kontak vendor", backgroundColor: Colors.white);
                        Future.delayed(Duration.zero, ()async{
                          await accountController.getPersonContact();
                          Navigator.pop(context);
                        });
                      }else{
                        Get.snackbar('Gagal', "Gagal menambah kontak vendor", backgroundColor: Colors.white);
                      }
                    }else{
                      Get.snackbar('Gagal', "Gagal menambah kontak vendor atau customer", backgroundColor: Colors.white);
                    }
                  }
                }, 
                child: Text("Save", style: kDefaultTextStyle(color: Colors.white, fontSize: 16),)),
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
                        controller: contactNameController,
                        decoration: InputDecoration(
                          label: Text("Contact Name", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();
                                setState(() {
                                  phoneContact = contact;
                                  contactNumberController.text = phoneContact!.phoneNumber?.number ?? "Unknown number";
                                  contactNameController.text = phoneContact?.fullName ?? 'Unknonwn name';
                                });
                            },
                            icon: const Icon(CupertinoIcons.person_2_square_stack),),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: contactNumberController,
                        decoration: InputDecoration(
                          label: Text("Phone Number", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Text("Contact Type", style: kDefaultTextStyle(fontSize: 16),),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RadioListTile<Dataperson>(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text('Customer', style: kDefaultTextStyle(fontSize: 14),),
                              groupValue: dataperson,
                              value: Dataperson.customer,
                              onChanged:(Dataperson? value) { 
                                setState(() {
                                  dataperson = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<Dataperson>(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text('Vendor', style: kDefaultTextStyle(fontSize: 14),),
                              groupValue: dataperson,
                              value: Dataperson.vendor,
                              onChanged:(Dataperson? value) { 
                                setState(() {
                                  dataperson = value;
                                });
                              },
                            ),
                          ),
                        ],
                      )
                    ]
                  ),
                ),
              ],
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

enum Dataperson{
  customer,
  vendor
}