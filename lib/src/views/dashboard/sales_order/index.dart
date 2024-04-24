import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/buttons/default_button.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class SalesOrderPage extends StatefulWidget {
  const SalesOrderPage({super.key});

  @override
  State<SalesOrderPage> createState() => _SalesOrderPageState();
}

class _SalesOrderPageState extends State<SalesOrderPage> {
  TextEditingController namaCustomerController = TextEditingController();
  TextEditingController nomorResiController = TextEditingController();
  String? metodePembayaran;
  String? datePickedOrder;
  String? datePickedSampai;
  String dropDownValueWeek = 'Metode Pembayaran';
  var itemsLeverage = [     
    'Metode Pembayaran', 
    "QRIS",
    "Transfer Bank",
    "OVO",
    "Dana",
    "Shoppe Pay" 
  ]; 

  @override
  void dispose() {
    namaCustomerController.dispose();
    nomorResiController.dispose();
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
                          label: Text("Nama Customer", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          label: Text("Nomor Resi", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tanggal Order", style: kDefaultTextStyle(fontSize: 16),),
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
                                          datePickedOrder = formattedDate; //set foratted date to TextField value. 
                                      });
                                    }
                                  }, 
                                  icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), label: Text(DateFormat('dd/MM/yyyy').format(datePickedOrder != null ? DateTime.parse(datePickedOrder!) : DateTime.now()), style: kDefaultTextStyle(fontSize: 13),))
                              ],
                            ),
                          ),

                          Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tanggal Sampai", style: kDefaultTextStyle(fontSize: 16),),
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
                                          datePickedOrder = formattedDate; //set foratted date to TextField value. 
                                      });
                                    }
                                  }, 
                                  icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), label: Text(DateFormat('dd/MM/yyyy').format(datePickedOrder != null ? DateTime.parse(datePickedOrder!) : DateTime.now()), style: kDefaultTextStyle(fontSize: 13),))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white60, 
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 0.3, color: Colors.white60),
                        ),
                        child: DropdownButton(
                          style: kDefaultTextStyle(fontSize: 16),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          underline: const SizedBox(),
                          value: dropDownValueWeek,                           
                          icon: const Icon(Icons.keyboard_arrow_down),     
                          items: itemsLeverage.map((String items) { 
                            return DropdownMenuItem( 
                              value: items, 
                              child: Text(items, style: kDefaultTextStyle(),), 
                            ); 
                          }).toList(), 
                          onChanged: (String? newValue) {  
                            setState(() { 
                              dropDownValueWeek = newValue!; 
                              }); 
                            }, 
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                            child: kDeafultButton(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              textColor: Colors.black,
                              onPressed: (){},
                              title: "Konfirmasi Pembayaran",
                              backgroundColor: Colors.white
                            ),
                          ),
                        )
                    ]
                  ),
                ),
                const SizedBox(height: 15),
                kDeafultButton(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                  onPressed: (){},
                  title: "Print",
                  backgroundColor: Colors.blue
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}