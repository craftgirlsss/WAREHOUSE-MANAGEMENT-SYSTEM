import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/account_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

import '../update_stock/adding_contact_page.dart';
import 'edit_contact.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  AccountController accountController = Get.put(AccountController());  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: ()async{
                await accountController.getPersonContact();
                setState(() {
                  
                });
              },
              child: Obx(
                () => accountController.listContacts.length == 0 ? const SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Produk item kosong"),
                        ],
                      ),
                    ),
                  ) :  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.indigo.shade800,
                        title: Text("Contacts", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                          actions: [
                            IconButton(onPressed: (){
                              Get.to(() => const AddingContactPage());
                            }, icon: const Icon(Icons.add, color: Colors.white))
                        ],
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(60), 
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: TextField(
                                      style: kDefaultTextStyle(),
                                      textAlign: TextAlign.start,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 3),
                                        hintText: "Search Contact",
                                        prefixIcon: const Icon(CupertinoIcons.search),
                                        hintStyle: kDefaultTextStyle(),                                
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25)
                                        )
                                      ),
                                    ),
                                  )
                                ),
                                GestureDetector(
                                  onTap: (){},
                                  child: Container(
                                    color: Colors.transparent,
                                    child: const Row(
                                      children: [
                                        Icon(CupertinoIcons.arrow_up_down,size: 25,
                                          color: Colors.white,),
                                        Icon(CupertinoIcons.text_alignleft, size: 25,
                                          color: Colors.white,)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList.builder(
                        itemCount: accountController.listContacts.length,
                        itemBuilder: (context, index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                                onTap: (){
                                  Get.to(() => EditContactPage(
                                    contactName: accountController.listContacts[index]['nama'],
                                    contactNumber: accountController.listContacts[index]['no_telp'],
                                    contactType: accountController.listContacts[index]['type'] == "customer" ? ContactType.customer : ContactType.vendor,
                                  ));
                                },
                                shape: RoundedRectangleBorder( //<-- SEE HERE
                                  side: const BorderSide(width: 0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Colors.white60,
                                leading: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: GlobalVariable.mainColor
                                  ),
                                  child: Center(child: Text("${accountController.listContacts[index]['nama'][0]}", style: kDefaultTextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)),
                                ),
                                trailing: Container(
                                  width: MediaQuery.of(context).size.width / 4.5,
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 10, 
                                        height: 10, 
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: GlobalVariable.mainColor,),),
                                      const SizedBox(width: 5),
                                      Text(accountController.listContacts[index]['type'].toString().capitalize!, style: kDefaultTextStyle(),)
                                    ],
                                  ),
                                ),                            
                                title: Text(accountController.listContacts[index]['nama'], style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                // subtitle: const Text("Assitance Manager"),
                            ),
                          );
                        }, 
                      )
                    ],
                  ),
              ),
            )
          ),
        ),
        Obx(() => accountController.isLoading.value ? floatingLoading() : const SizedBox()),
      ],
    );
  }
}