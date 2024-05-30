import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/customer_controller.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/home/select_items.dart';

class UpdateStockPage extends StatefulWidget {
  const UpdateStockPage({super.key});

  @override
  State<UpdateStockPage> createState() => _UpdateStockPageState();
}

class _UpdateStockPageState extends State<UpdateStockPage> {
  String? itemSelected;
  TextEditingController namaVendorController = TextEditingController();
  CustomerController customerController = Get.put(CustomerController());
  ProductControllers productControllers = Get.find();
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
                        controller: namaVendorController,
                        readOnly: true,
                        onTap: () async {
                          customerController.getVendor();
                          Get.defaultDialog(
                            backgroundColor: Colors.white,
                            title: "Daftar Vendor",
                            titleStyle: kDefaultTextStyle(color: Colors.black, fontSize: 16),
                            titlePadding: const EdgeInsets.only(top: 15),
                            content: Obx(
                              () => customerController.isLoading.value ? Center(
                                child: floatingLoading(),
                              ) : customerController.listVendor.length == 0 ? Container(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(CupertinoIcons.person_2_square_stack, color: Colors.black,),
                                    Text("Tidak ada vendor", style: kDefaultTextStyle(color: Colors.black),)
                                  ],
                                ),
                              ) : SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                      customerController.listVendor.length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 5),
                                            child: ListTile(
                                              tileColor: Colors.black12,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(7)
                                              ),
                                              dense: true,
                                              title: Text(customerController.listVendor[index]['nama'] ?? 'Tidak ada nama', style: kDefaultTextStyle(color: Colors.black, fontSize: 14),),
                                              onTap: () async {
                                                setState(() {
                                                  namaVendorController.text = customerController.listVendor[index]['nama'];
                                                  productControllers.vendorNameItemSelected.value = customerController.listVendor[index]['nama'];
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        }
                                    )
                                  ),
                                ),
                              ),
                          );
                          },
                        decoration: InputDecoration(
                          label: Text("Nama Vendor", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text("Transaction Date", style: kDefaultTextStyle(fontSize: 16),),
                      Obx(() => ElevatedButton.icon(
                          onPressed: productControllers.isLoading.value ? (){} : () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate:DateTime(2023), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now()
                            );
                            if(pickedDate != null ){                      
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              setState(() {
                                datePicked = formattedDate; //set foratted date to TextField value. 
                                productControllers.dateItemSelected.value = datePicked ?? DateFormat('yyyy-MM-dd').format(DateTime.now());  
                              });
                            }
                          }, 
                          icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), label: Text(DateFormat('dd/MM/yyyy').format(datePicked != null ? DateTime.parse(datePicked!) : DateTime.now()), style: kDefaultTextStyle(fontSize: 13),)),
                      )
                    ]
                  ),
                ),
                const SizedBox(height: 15),
                ListTile(
                  onTap: (){
                    Get.to(() => const SelectItems());
                  },
                  shape: RoundedRectangleBorder( //<-- SEE HERE
                    side: const BorderSide(width: 0.2),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  tileColor: Colors.white.withOpacity(0.7),
                  title: Obx(() => Text("${productControllers.itemNameSelected.value == '' ? "Select Item" : productControllers.itemNameSelected.value}", style: kDefaultTextStyle(fontSize: 14))),
                  trailing: Obx(() => Container(
                      width: 100,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(productControllers.itemCountSelected.value.toString(), overflow: TextOverflow.ellipsis, maxLines: 1, style: kDefaultTextStyle(fontSize: 12),),
                          Expanded(child: Text(" x ${productControllers.priceBook.value}", overflow: TextOverflow.ellipsis, maxLines: 1, style: kDefaultTextStyle(fontSize: 12),)),
                          Icon(Icons.keyboard_arrow_right_rounded),
                        ],
                      ),
                    ),
                  ), 
                ),
                const SizedBox(height: 15),
                Container(
                  width: MediaQuery.of(context).size.width,                
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Obx(
                    () => productControllers.isLoading.value ? TextField(
                      maxLines: 1,
                      decoration: InputDecoration(
                        label: Text("Notes", style: kDefaultTextStyle(fontSize: 16),),
                        labelStyle: kDefaultTextStyle(fontSize: 16),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))
                      ),
                    ) : TextField(
                      maxLines: 1,
                      onChanged: (value) {
                        productControllers.notesitemSelected.value = value;
                      },
                      decoration: InputDecoration(
                        label: Text("Notes", style: kDefaultTextStyle(fontSize: 16),),
                        labelStyle: kDefaultTextStyle(fontSize: 16),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))
                      ),
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