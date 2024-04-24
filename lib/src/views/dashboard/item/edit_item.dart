import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class EditItem extends StatefulWidget {
  final String? namaItem;
  final String? skuItem;
  final String? openingStockItem;
  final String? namaPenerbitItem;
  final String? categoryItem;
  final String? hargaPenjualanItem;
  final String? biayaItem;
  const EditItem({super.key, this.namaItem, this.skuItem, this.openingStockItem, this.namaPenerbitItem, this.categoryItem, this.hargaPenjualanItem, this.biayaItem});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController namaItemController = TextEditingController();
  TextEditingController skuItemController = TextEditingController();
  TextEditingController openingStockItemController = TextEditingController();
  TextEditingController namaPenerbitItemController = TextEditingController();
  TextEditingController categoryItemController = TextEditingController();
  TextEditingController hargaPenjualanItemController = TextEditingController();
  TextEditingController biayaItemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    namaItemController.text = widget.namaItem ?? 'Unknown';
    skuItemController.text = widget.skuItem ?? 'Unknown';
    openingStockItemController.text = widget.openingStockItem ?? 'Unknown';
    namaPenerbitItemController.text = widget.namaPenerbitItem ?? 'Unknown';
    categoryItemController.text = widget.categoryItem ?? 'Unknown';
    hargaPenjualanItemController.text = widget.hargaPenjualanItem ?? 'Rp 0';
    biayaItemController.text = widget.biayaItem ?? 'Rp 0';
  }

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
              title: Text("Edit Item", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                          controller: openingStockItemController,
                          decoration: const InputDecoration(
                            label: Text("Opening Stock"),
                          ),
                        ),
                        TextField(
                          controller: namaPenerbitItemController,
                          decoration: const InputDecoration(
                            label: Text("Nama Penerbit"),
                          ),
                        ),
                        TextField(
                          controller: categoryItemController,
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