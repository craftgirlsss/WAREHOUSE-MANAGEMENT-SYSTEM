import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/views/dashboard/home/index.dart';
import 'package:warehouseapp/src/views/dashboard/item/index.dart';
import 'package:warehouseapp/src/views/dashboard/sales_order/add_new_customer.dart';
import 'package:warehouseapp/src/views/dashboard/update_stock/index.dart';
import 'dashboard/history/index.dart';
import 'dashboard/item/add_item.dart';
import 'dashboard/sales_order/index.dart';
import 'dashboard/settings/index.dart';
import 'dashboard/tracking/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ProductControllers productControllers = Get.put(ProductControllers());
  int selectedIndex = 0;
  String nameAppBar = 'Home';
  static  List<Widget> widgetOptions = <Widget>[
    const HomePage(),
    const ItemsPage(
      withAppBar: false,
    ),
    const SalesOrderPage(),
    const UpdateStockPage(),
    const TrackingBarcode(),
    const StockHistory(),
    const SettingsTab(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    onItemTapped(0);
    selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nameAppBar, style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.indigo.shade800,
        actions: [
          if(selectedIndex == 3)
            Obx(() => TextButton(
              onPressed: productControllers.isLoading.value ? (){} : (){
                if(productControllers.vendorNameItemSelected.value == '' 
                || productControllers.dateItemSelected.value == '' 
                || productControllers.notesitemSelected.value == '' 
                || productControllers.itemNameSelected.value == '' 
                || productControllers.itemCountSelected.value < 2){
                  Get.snackbar("Gagal", "Mohon isi semua field dan pastikan jumlah barang tidak kurang dari 2", backgroundColor: Colors.white);
                }else{
                  productControllers.updateStock();
                }
              }, 
              child: Text("Save", style: kDefaultTextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),)),
            ) 
          else if(selectedIndex == 1)
            IconButton(
              onPressed: (){
                Get.to(() => const AddItems());
              },
              icon: const Icon(Icons.add, color: Colors.white),
            )
          else if(selectedIndex == 2)
            IconButton(
              onPressed: (){
                Get.to(() => const AddNewCustomer());
              },
              icon: const Icon(Icons.add, color: Colors.white),
            )
          else if(selectedIndex == 5)
            IconButton(onPressed: (){}, icon: const Icon(Icons.filter_alt_rounded, color: Colors.white))
          else 
            const SizedBox()
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                size: 40,
                weight: 40,
                color: Colors.white,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        backgroundColor: Colors.indigo,
        child: SafeArea(
          child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 30),
              title: Text('Back', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: selectedIndex == 0 ? Colors.white12 : Colors.transparent,
              leading: const Icon(Icons.home, color: Colors.white, size: 30),
              title: Text('Home', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  onItemTapped(0);
                  nameAppBar = "Home";
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              tileColor: selectedIndex == 1 ? Colors.white12 : Colors.transparent,
              leading: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 30),
              title: Text('Item', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  nameAppBar = "Items";
                  onItemTapped(1);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              tileColor: selectedIndex == 2 ? Colors.white12 : Colors.transparent,
              leading: const Icon(CupertinoIcons.cube_box, color: Colors.white, size: 30),
              title: Text('Sales Order', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  nameAppBar = "Sales Order";
                  onItemTapped(2);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              tileColor: selectedIndex == 3 ? Colors.white12 : Colors.transparent,
              leading: const Icon(Icons.update, color: Colors.white, size: 30),
              title: Text('Update Stock', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  nameAppBar = "Update Stock";
                  onItemTapped(3);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              tileColor: selectedIndex == 4 ? Colors.white12 : Colors.transparent,
              leading: const Icon(CupertinoIcons.barcode_viewfinder, color: Colors.white, size: 30),
              title: Text('Tracking', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  nameAppBar = "Tracking";
                  onItemTapped(4);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              tileColor: selectedIndex == 5 ? Colors.white12 : Colors.transparent,
              leading: const Icon(Icons.history, color: Colors.white, size: 30),
              title: Text('History', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  nameAppBar = "Stock History";
                  onItemTapped(5);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              tileColor: selectedIndex == 6 ? Colors.white12 : Colors.transparent,
              leading: const Icon(Icons.settings, color: Colors.white, size: 30),
              title: Text('Settings', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  nameAppBar = "Settings";
                  onItemTapped(6);
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
        ),
      ),
      body: 
          Center(
            child: widgetOptions[selectedIndex],
          )
    );
  }
}