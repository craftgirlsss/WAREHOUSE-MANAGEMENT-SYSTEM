import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/helpers/currencies/format_currency.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/views/dashboard/item/edit_item.dart';

class ItemDetail extends StatefulWidget {
  final int? id;
  final int? idCategory;
  final String? title;
  final int? stockLength;
  final String? category;
  final int? sellingPrice;
  final double? costPrice;
  final String? sku;
  final String? penerbit;
  const ItemDetail({super.key, this.title, this.stockLength, this.category, this.sellingPrice, this.costPrice, this.sku, this.penerbit, this.idCategory, this.id});

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(DateTime.parse("2023-04-13"), 0),
      ChartData(DateTime.parse("2023-05-12"), 9),
      ChartData(DateTime.parse("2023-06-12"), 5),
      ChartData(DateTime.parse("2023-07-12"), 8),
      ChartData(DateTime.parse("2023-08-12"), 20),
      ChartData(DateTime.parse("2023-09-12"), 24),
      ChartData(DateTime.parse("2023-10-12"), 20),
      ChartData(DateTime.parse("2023-11-12"), 24)
    ];
    return Stack(
      children: [
        backgroundColor(context),
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.indigo.shade800,
              title: Text("Item Details", style: kDefaultTextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
                  IconButton(onPressed: (){}, icon: const Icon(Icons.delete, color: Colors.white)),
                  IconButton(onPressed: (){
                    Get.to(() => EditItem(
                      id: widget.id,
                      idCategory: widget.idCategory,
                      biayaItem: widget.costPrice,
                      categoryItem: widget.category,
                      hargaPenjualanItem: widget.sellingPrice,
                      namaItem: widget.title,
                      namaPenerbitItem: widget.penerbit ?? 'Unknown',
                      openingStockItem: widget.stockLength,
                      skuItem: widget.sku,
                    ));
                  }, icon: const Icon(Icons.edit, color: Colors.white)),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_outlined, color: Colors.white)),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: Colors.white70,
                    leading: Container(
                      color: Colors.transparent,
                      width: 35,
                      height: 35,
                      child: const Icon(Icons.image_outlined, color: Colors.black87, size: 40,)
                    ),
                    title: Text(widget.title ?? "Unknown", overflow: TextOverflow.ellipsis, style: kDefaultTextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    subtitle: Text("Available Stock : ${widget.stockLength ?? 0}")
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category : ${widget.category ?? "Unknown"}"),
                        const Text("Reorder Point : 2"),
                        Text("SKU# : ${widget.sku}"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Selling Price : ${formatCurrencyId.format(widget.sellingPrice ?? 0)}"),
                        const SizedBox(height: 5),
                        Text("Cost Price : ${formatCurrencyId.format(widget.costPrice ?? 0)}"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white.withOpacity(0.7)
                    ),
                    padding: const EdgeInsets.all(15),
                    child: SfCartesianChart(
                      legend: Legend(
                        title: LegendTitle(text: "Sales Trend", textStyle: kDefaultTextStyle(fontWeight: FontWeight.bold)),
                        isVisible: true
                      ),
                      primaryXAxis: DateTimeAxis(
                        interval: 1,
                        dateFormat: DateFormat("MMM dd"),
                        majorGridLines: const MajorGridLines(color: Colors.transparent),
                        labelStyle: kDefaultTextStyle(color: Colors.black),
                      ), 
                      primaryYAxis: NumericAxis(
                        interval: 5,
                        maximum: 28,
                        majorGridLines: const MajorGridLines(
                          color: Colors.black
                        ),
                        borderColor: Colors.black,
                        labelStyle: kDefaultTextStyle(color: Colors.black),
                      ),
                      series: <CartesianSeries>[
                          // Renders line chart
                          LineSeries<ChartData, DateTime>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y
                          )
                      ]
                    )
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 10),
                  //       child: ElevatedButton.icon(onPressed: (){}, icon: const Icon(CupertinoIcons.arrow_2_circlepath), label: const Text("Update Stock")),
                  //     )
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}