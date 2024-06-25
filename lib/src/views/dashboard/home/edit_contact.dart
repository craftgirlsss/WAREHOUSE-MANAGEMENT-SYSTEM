import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/customer_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class EditContactPage extends StatefulWidget {
  final int? id;
  final String? contactName;
  final String? contactNumber;
  final ContactType? contactType;
  const EditContactPage({super.key, this.contactName, this.contactNumber, this.contactType, this.id});

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  CustomerController customerController = Get.find();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  String? contactType;
  ContactType? dataperson = ContactType.customer;
  PhoneContact? phoneContact;
  String? nameContact;


  @override
  void initState() {
    super.initState();
    contactNameController.text = widget.contactName ?? 'Unknonwn Name';
    contactNumberController.text = widget.contactNumber ?? '0';
    dataperson = widget.contactType;
    if(dataperson == ContactType.customer){
      setState(() {
        contactType = "Customer";
      });
    }else{
      setState(() {
        contactType = "Vendor";
      });
    }
  }

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
            appBar: kDefaultAppBar(context, title: "Edit Contacts", actions: [
              TextButton(onPressed: () async {
                if(contactNameController.text == "" || contactNumberController.text == ""){
                  Get.snackbar("Gagal", "Field tidak boleh kosong", backgroundColor: Colors.white);
                }else{
                  if(dataperson == ContactType.customer){
                    await customerController.updateCustomer(id: widget.id, name: contactNameController.text, phone: contactNumberController.text).then((value) {
                      if(value){
                        Get.snackbar("Berhasil", "Berhasil update kontak", backgroundColor: Colors.white);
                        
                        Navigator.pop(context);
                      }else{
                        Get.snackbar("Gagal", "Gagal update kontak", backgroundColor: Colors.white);
                      }
                    });
                  }else{
                    await customerController.updateVendor(id: widget.id, name: contactNameController.text, phone: contactNumberController.text).then((value) {
                      if(value){
                        Get.snackbar("Berhasil", "Berhasil update kontak", backgroundColor: Colors.white);
                        Navigator.pop(context);
                      }else{
                        Get.snackbar("Gagal", "Gagal update kontak", backgroundColor: Colors.white);
                      }
                    });
                  }
                }
              }, child: Text("Save", style: kDefaultTextStyle(color: Colors.white, fontSize: 16),))
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
                                  contactNumberController.text = phoneContact?.phoneNumber?.number ?? "Unknown number";
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
                        keyboardType: TextInputType.phone,
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
                        child: Text("Contact Type : $contactType", style: kDefaultTextStyle(fontSize: 16),),
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() => customerController.isLoading.value ? floatingLoading() : Container())
      ],
    );
  }
}

enum Dataperson{
  customer,
  vendor
}