import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/views/dashboard/homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  String nameAppBar = 'Home';
  static  List<Widget> widgetOptions = <Widget>[
    const HomePage(),
    Text(
      'Home',
      style: kDefaultTextStyle(color: Colors.green),
    ),
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
              leading: const Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 30),
              title: Text('Item', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  onItemTapped(1);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.cube_box, color: Colors.white, size: 30),
              title: Text('Sales Order', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  onItemTapped(1);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.update, color: Colors.white, size: 30),
              title: Text('Update', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  onItemTapped(1);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.barcode_viewfinder, color: Colors.white, size: 30),
              title: Text('Tracking', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  onItemTapped(1);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white, size: 30),
              title: Text('History', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  onItemTapped(1);
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white, size: 30),
              title: Text('Settings', style: kDefaultTextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
              onTap: () {
                setState(() {
                  onItemTapped(1);
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