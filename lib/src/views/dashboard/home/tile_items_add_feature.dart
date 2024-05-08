import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';

class SelectAndAddItems extends StatefulWidget {
  final String? title;
  final int? subtitleJumlahBuku;
  final int? item;
  const SelectAndAddItems({super.key, this.item, this.title, this.subtitleJumlahBuku});

  @override
  State<SelectAndAddItems> createState() => _SelectAndAddItemsState();
}

class _SelectAndAddItemsState extends State<SelectAndAddItems> {
  int item = 0;

  @override
  void initState() {
    super.initState();
    item = widget.item ?? 0;
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){},
      shape: RoundedRectangleBorder( //<-- SEE HERE
        side: const BorderSide(width: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.white60,
      leading: Container(
        color: Colors.transparent,
        width: 35,
        height: 35,
        child: const Icon(Icons.image_outlined, color: Colors.black87, size: 40,)
      ),
      trailing: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: GlobalVariable.mainColor,
          borderRadius: BorderRadius.circular(25),
          shape: BoxShape.rectangle
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(onPressed: (){
                setState(() {
                  item = item - 1;
                });
              }, icon: const Icon(Icons.remove, color: Colors.white)),
            ),
            Text(item.toString(), style: kDefaultTextStyle(fontSize: 12, color: Colors.white),),
            Expanded(
              child: IconButton(onPressed: (){
                setState(() {
                  item = item + 1;
                });
              }, icon: const Icon(Icons.add, color: Colors.white)),
            ),
          ],
        ),
      ),
      // Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Container(
      //       width: 10, 
      //       height: 10, 
      //       decoration: const BoxDecoration(shape: BoxShape.circle, color: GlobalVariable.mainColor,),),
      //     const SizedBox(width: 5),
      //     const Text("Customer")
      //   ],
      // ),                            
      title: Text(widget.title ?? 'Unknown', overflow: TextOverflow.ellipsis, maxLines: 1, style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
      subtitle: Row(
        children: [
          const Icon(Icons.book, color: GlobalVariable.mainColor, size: 13),
          Text(widget.subtitleJumlahBuku.toString()),
        ],
      ),
  );
  }
}