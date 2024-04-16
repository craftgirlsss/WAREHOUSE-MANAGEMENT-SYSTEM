import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
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
                        IconButton(onPressed: (){}, icon: const Icon(Icons.add, color: Colors.white))
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
                    itemCount: 3,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            onTap: (){},
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
                              child: Center(child: Text("A", style: kDefaultTextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 10, 
                                  height: 10, 
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: GlobalVariable.mainColor,),),
                                const SizedBox(width: 5),
                                const Text("Customer")
                              ],
                            ),                            
                            title: Text("Arum Purwita Sari", style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            subtitle: const Text("Assitance Manager"),
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