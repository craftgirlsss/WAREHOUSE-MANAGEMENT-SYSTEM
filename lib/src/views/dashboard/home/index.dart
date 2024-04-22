import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/models/data_chart_models.dart';
import 'package:warehouseapp/src/views/dashboard/home/contacts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ChartData> data;
  late TooltipBehavior tooltip;

  String dropDownValueToday = 'Today';
  // List of items in our dropdown Today menu 
  var itemsToday = [     
    'Today', 
    'This Week', 
    'This Month', 
    'Last 3 Month', 
    'Last 6 Month',
    'This Year',
    'All' 
  ]; 

  String dropDownValueWeek = 'This Week';
  // List of items in our dropdown Today menu 
  var itemsWeek = [     
    'This Week', 
    'Last Week', 
    'This Month', 
    'Last 3 Month', 
    'Last 6 Month',
    'This Year',
    'All' 
  ]; 
 
  @override
  void initState() {
    tooltip = TooltipBehavior(enable: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
            ChartData(1, 5, 5),
            ChartData(2, 10, 7),
            ChartData(3, 7, 3),
            ChartData(4, 5, 5),
            ChartData(5, 21, 5),
            ChartData(5, 17, 16),
        ];
    return Scaffold(
      body: Stack(
        children: [
          backgroundColor(context),
          ListView(
            padding: GlobalVariable.defaultPadding,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,                
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Summary", style: kDefaultTextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        DropdownButton(
                          borderRadius: BorderRadius.circular(15),
                          underline: const SizedBox(),
                          value: dropDownValueToday,                           
                          icon: const Icon(Icons.keyboard_arrow_down),     
                          items: itemsToday.map((String items) { 
                            return DropdownMenuItem( 
                              value: items, 
                              child: Text(items), 
                            ); 
                          }).toList(), 
                          onChanged: (String? newValue) {  
                            setState(() { 
                              dropDownValueToday = newValue!; 
                            }); 
                          }, 
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sold Quantities", style: kDefaultTextStyle(fontWeight: FontWeight.normal, fontSize: 17)),
                                  Text("0", style: kDefaultTextStyle(fontWeight: FontWeight.normal, fontSize: 17)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Earnings", style: kDefaultTextStyle(fontWeight: FontWeight.normal, fontSize: 17)),
                                  Text("Rp. 0", style: kDefaultTextStyle(fontWeight: FontWeight.normal, fontSize: 17)),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Purchased Quantities", style: kDefaultTextStyle(fontWeight: FontWeight.normal, fontSize: 17)),
                                  Text("0", style: kDefaultTextStyle(fontWeight: FontWeight.normal, fontSize: 17)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              color: Colors.transparent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Spendings", style: kDefaultTextStyle(fontWeight: FontWeight.normal, fontSize: 17)),
                                  Text("Rp. 0", style: kDefaultTextStyle(fontWeight: FontWeight.normal, fontSize: 17)),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Row untuk items
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.7)
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white38
                            ),
                            child: const Icon(Icons.shopping_cart_outlined)),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("All Items"),
                              Text("0")
                            ],
                          ),
                          const Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(Icons.arrow_right),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => const ContactPage());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.7)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white38
                              ),
                              child: const Icon(Icons.person)),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("All Contacts"),
                                Text("0")
                              ],
                            ),
                            const Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.arrow_right),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              // Analytics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Analytics", style: kDefaultTextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),),
                  DropdownButton(
                    borderRadius: BorderRadius.circular(15),
                    underline: const SizedBox(),
                    style: kDefaultTextStyle(fontSize: 14, color: Colors.white),
                    dropdownColor: Colors.black.withOpacity(0.9),
                    value: dropDownValueWeek,                           
                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white,),
                    items: itemsWeek.map((String items) { 
                      return DropdownMenuItem( 
                        value: items, 
                        child: Text(items), 
                      ); 
                    }).toList(), 
                    onChanged: (String? newValue) {  
                      setState(() { 
                        dropDownValueWeek = newValue!; 
                      }); 
                    }, 
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Chart
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white.withOpacity(0.7)
                ),
                padding: const EdgeInsets.all(15),
                child: SfCartesianChart(
                  legend: Legend(
                    title: LegendTitle(text: "Transaction Trend", textStyle: kDefaultTextStyle(fontWeight: FontWeight.bold)),
                    isVisible: true
                  ),
                  primaryXAxis: NumericAxis(
                    interval: 1,
                    majorGridLines: const MajorGridLines(color: Colors.transparent),
                    labelStyle: kDefaultTextStyle(color: Colors.black),
                  ), 
                  primaryYAxis: NumericAxis(
                    interval: 5,
                    maximum: 23,
                    majorGridLines: const MajorGridLines(
                      color: Colors.black
                    ),
                    borderColor: Colors.black,
                    labelStyle: kDefaultTextStyle(color: Colors.black),
                  ),
                  series: <CartesianSeries<ChartData, double>>[
                      // Renders column chart
                      ColumnSeries<ChartData, double>(
                        name: "Sales",
                          color: const Color.fromRGBO(88, 0, 185, 1),
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y
                      ),
                      ColumnSeries<ChartData, double>(
                        name: "Purchase",
                        color: const Color.fromRGBO(139, 63, 236, 1),
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y1
                      ),
                  ]
                )
              )
            ],
          ),
        ],
      ),
    );
  }
}