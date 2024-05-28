import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'category_details.dart';

class CategorySettings extends StatefulWidget {
  const CategorySettings({super.key});

  @override
  State<CategorySettings> createState() => _CategorySettingsState();
}

class _CategorySettingsState extends State<CategorySettings> {
  ProductControllers productControllers = Get.put(ProductControllers());
  @override
  void initState() {
    super.initState();
    productControllers.getCategoryItem();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundColor(context),
        RefreshIndicator(
          onRefresh: () async {
            await productControllers.getCategoryItem();
            setState(() {});
          },
          child: GestureDetector(
            onTap: () => focusManager(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.indigo.shade800,
                    title: Text("Category",
                        style: kDefaultTextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      tooltip:
                          MaterialLocalizations.of(context).openAppDrawerTooltip,
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                              title: "Informasi",
                              titlePadding: const EdgeInsets.only(top: 15),
                                contentPadding: const EdgeInsets.only(left: 15, right: 15),
                                content: const Text(
                                    "Apakah anda yakin ingin menghapus item?"),
                                cancel: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ya",
                                        style: kDefaultTextStyle(
                                            color: GlobalVariable.mainColor))),
                                confirm: TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, 
                                  child: Text("Tidak",
                                        style: kDefaultTextStyle(
                                            color: GlobalVariable.mainColor)))            
                                );
                          },
                          icon: const Icon(Icons.delete, color: Colors.white))
                    ],
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 50,
                            child: TextField(
                              style: kDefaultTextStyle(),
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  hintText: "Search Category",
                                  prefixIcon: const Icon(CupertinoIcons.search),
                                  hintStyle: kDefaultTextStyle(),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25))),
                            ),
                          )),
                    ),
                  ),
                  Obx(() => productControllers.isLoading.value ? SliverList(delegate: SliverChildListDelegate([
                    Center(child: Text("Getting item....", style: kDefaultTextStyle(color: Colors.white),))
                  ])) : productControllers.categoryModels.length == 0 ? SliverList(delegate: SliverChildListDelegate([
                    Center(child: Text("Tidak ada item", style: kDefaultTextStyle(color: Colors.white),))
                  ])) :
                  SliverList.builder(
                      itemCount: productControllers.categoryModels.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => const CategoryDetails());
                            },
                            shape: RoundedRectangleBorder(
                              //<-- SEE HERE
                              side: const BorderSide(width: 0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            tileColor: Colors.white60,
                            trailing: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [Text("1")],
                            ),
                            title: Text(
                              "Buku Pelajaran",
                              style:
                                  kDefaultTextStyle(fontWeight: FontWeight.normal),
                            ),
                            subtitle: Text(
                              "${productControllers.categoryModels[index].kode} - ${productControllers.categoryModels[index].nama}",
                              style: kDefaultTextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.indigo.shade800,
                shape: const CircleBorder(),
                elevation: 0,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
