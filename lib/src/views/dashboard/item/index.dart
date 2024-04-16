import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

import 'item_detail.dart';

class ItemsPage extends StatefulWidget {
  const ItemsPage({super.key});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
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
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.indigo.shade800,
                  leadingWidth: 0,
                  titleSpacing: 0,
                  automaticallyImplyLeading: false,
                  title: Padding(
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
                                hintText: "Search Items",
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
                SliverList.builder(
                  itemCount: 3,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          onTap: (){
                            Get.to(() => const ItemDetail(
                              stockLength: 5,
                              title: "F01 - SwiftUI for Beginner",
                              category: "Novel",
                            ));
                          },
                          shape: RoundedRectangleBorder( //<-- SEE HERE
                            side: const BorderSide(width: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.white,
                          leading: Container(
                            color: Colors.transparent,
                            width: 35,
                            height: 35,
                            child: const Icon(Icons.image_outlined, color: Colors.black87, size: 40,)
                          ),
                          trailing: const Text("5"),                            
                          title: Text("F01 - SwiftUI for Beginner", overflow: TextOverflow.ellipsis, style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.folder_open, size: 20),
                              const SizedBox(width: 3),
                              Text("Novel", style: kDefaultTextStyle(fontSize: 11))
                            ],
                          ),
                      ),
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