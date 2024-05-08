import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

import '../update_stock/adding_contact_page.dart';
import 'tile_items_add_feature.dart';

class SelectItems extends StatefulWidget {
  const SelectItems({super.key});

  @override
  State<SelectItems> createState() => _SelectItemsState();
}

class _SelectItemsState extends State<SelectItems> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.indigo.shade800,
                    title: Text("Select Items", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                        TextButton(
                          onPressed: (){
                          Get.to(() => const AddingContactPage());
                        }, child: Text("Done", style: kDefaultTextStyle(color: Colors.white),))
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
                                    hintText: "Search Item Name",
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList.builder(
                    itemCount: 3,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SelectAndAddItems(
                          subtitleJumlahBuku: 2,
                          title: "F$index - Harry Potter Episode ${index+1}",
                          item: 1,
                        )
                      );
                    }, 
                  )
                ],
              )
          ),
        ),
      ],
    );
  }
}