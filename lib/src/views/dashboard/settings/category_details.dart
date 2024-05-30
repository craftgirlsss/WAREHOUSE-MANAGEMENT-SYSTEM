import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/settings/add_category.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: kDefaultAppBar(
              context, 
              title: "Update Stock Detail",
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white60,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Items"),
                            Text("1")
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white60,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Quantity"),
                              Text("8")
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  ListTile(
                    onTap: (){},
                    shape: RoundedRectangleBorder( //<-- SEE HERE
                      side: const BorderSide(width: 0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    tileColor: Colors.white60,
                    leading: Container(
                      color: Colors.transparent,
                      width: 35,
                      height: 35,
                      child: const Icon(Icons.image_outlined, color: Colors.black87, size: 40,)
                    ),                          
                    title: Text("F01 - SwiftUI for Beginner", overflow: TextOverflow.ellipsis, style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 13),),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.folder_open, size: 20),
                        const SizedBox(width: 3),
                        Text("Novel", style: kDefaultTextStyle(fontSize: 11))
                      ],
                    ),
                ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCategooryPage()));
            }, 
            backgroundColor: Colors.indigo.shade800, shape: const CircleBorder(), elevation: 0, child: const Icon(Icons.add, color: Colors.white,),),
          ),
        ),
      ],
    );
  }
}