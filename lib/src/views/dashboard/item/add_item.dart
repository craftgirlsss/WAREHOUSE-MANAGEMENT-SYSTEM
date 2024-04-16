import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class AddItems extends StatefulWidget {
  const AddItems({super.key});

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  TextEditingController namaItemController = TextEditingController();
  TextEditingController skuItemController = TextEditingController();
  TextEditingController openingStockItemController = TextEditingController();
  TextEditingController namaPenerbitItemController = TextEditingController();
  TextEditingController categoryItemController = TextEditingController();
  TextEditingController hargaPenjualanItemController = TextEditingController();
  TextEditingController biayaItemController = TextEditingController();

  @override
  void dispose() {
    namaItemController.dispose();
    skuItemController.dispose();
    openingStockItemController.dispose();
    namaPenerbitItemController.dispose();
    categoryItemController.dispose();
    hargaPenjualanItemController.dispose();
    biayaItemController.dispose();
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
            appBar: AppBar(
              backgroundColor: Colors.indigo.shade800,
              title: Text("Add Item", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                  TextButton(onPressed: (){}, child: Text("Save", style: kDefaultTextStyle(color: Colors.white),))
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      child: Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage('assets/images/empty_image.png'), fit: BoxFit.cover)
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: (){
                                print("Ditekan");
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                                ),
                                child: const Icon(CupertinoIcons.camera_fill, color: Colors.black54),
                              ),
                            ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white60,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: namaItemController,
                          decoration: const InputDecoration(
                            label: Text("Nama Item"),
                          ),
                        ),
                        TextField(
                          controller: skuItemController,
                          decoration: const InputDecoration(
                            label: Text("SKU"),
                          ),
                        ),
                        TextField(
                          controller: namaItemController,
                          decoration: const InputDecoration(
                            label: Text("Nama Item"),
                          ),
                        ),
                        TextField(
                          controller: openingStockItemController,
                          decoration: const InputDecoration(
                            label: Text("Opening Stock"),
                          ),
                        ),
                        TextField(
                          controller: namaItemController,
                          readOnly: true,
                          onTap: (){},
                          decoration: InputDecoration(
                            label: const Text("Category"),
                            suffixIcon: IconButton(
                              onPressed: (){}, 
                              icon: const Icon(Icons.add)
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white60,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: 
                          TextField(
                            controller: openingStockItemController,
                            decoration: const InputDecoration(
                              label: Text("Harga Penjualan"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(child: 
                          TextField(
                            controller: openingStockItemController,
                            decoration: const InputDecoration(
                              label: Text("Biaya"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}