import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

import 'adding_contact_page.dart';

class UpdateStockPage extends StatefulWidget {
  const UpdateStockPage({super.key});

  @override
  State<UpdateStockPage> createState() => _UpdateStockPageState();
}

class _UpdateStockPageState extends State<UpdateStockPage> {
  String? datePicked;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
                        decoration: InputDecoration(
                          label: Text("Contact Name", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                          suffixIcon: IconButton(
                            onPressed: (){
                              Get.to(() => const AddingContactPage());
                            },
                            icon: const Icon(Icons.add),),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text("Transaction Date", style: kDefaultTextStyle(fontSize: 16),),
                      ElevatedButton.icon(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2024), //get today's date
                            firstDate:DateTime(2023), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now()
                          );
                          if(pickedDate != null ){                      
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            setState(() {
                                datePicked = formattedDate; //set foratted date to TextField value. 
                            });
                          }
                        }, 
                        icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), label: Text(DateFormat('dd/MM/yyyy').format(datePicked != null ? DateTime.parse(datePicked!) : DateTime.now()), style: kDefaultTextStyle(fontSize: 13),))
                    ]
                  ),
                ),
                const SizedBox(height: 15),
                ListTile(
                  onTap: (){},
                  shape: RoundedRectangleBorder( //<-- SEE HERE
                    side: const BorderSide(width: 0.2),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  tileColor: Colors.white.withOpacity(0.7),
                  title: const Text("Select Items"),
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ),
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,                
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      label: Text("Notes", style: kDefaultTextStyle(fontSize: 16),),
                      labelStyle: kDefaultTextStyle(fontSize: 16),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}