import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class AddingContactPage extends StatefulWidget {
  const AddingContactPage({super.key});

  @override
  State<AddingContactPage> createState() => _AddingContactPageState();
}

class _AddingContactPageState extends State<AddingContactPage> {
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  String? datePicked;
  Dataperson? dataperson = Dataperson.customer;
  PhoneContact? phoneContact;
  String? nameContact;

  @override
  void dispose() {
    contactNameController.dispose();
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
              TextButton(onPressed: (){}, child: Text("Save", style: kDefaultTextStyle(color: Colors.white, fontSize: 16),))
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
      ],
    );
  }
}

enum Dataperson{
  customer,
  vendor
}