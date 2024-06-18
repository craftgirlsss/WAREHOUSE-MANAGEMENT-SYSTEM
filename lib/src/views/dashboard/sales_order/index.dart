import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/buttons/default_button.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/customer_controller.dart';
import 'package:warehouseapp/src/helpers/currencies/format_currency.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:warehouseapp/src/helpers/random_string.dart';
import 'package:warehouseapp/src/views/dashboard/sales_order/pdf_preview.dart';

class SalesOrderPage extends StatefulWidget {
  const SalesOrderPage({super.key});

  @override
  State<SalesOrderPage> createState() => _SalesOrderPageState();
}

class _SalesOrderPageState extends State<SalesOrderPage> {
  TextEditingController namaCustomerController = TextEditingController();
  TextEditingController nomorResiController = TextEditingController();
  CustomerController customerController = Get.put(CustomerController());
  String? randomString;
  bool showPreview = false;
  String? datePickedOrder;
  String? datePickedSampai;
  String dropDownValueWeek = 'Metode Pembayaran';
  var itemsLeverage = [     
    'Metode Pembayaran', 
    "QRIS",
    "Transfer Bank",
    "OVO",
    "Dana",
    "Shoppe Pay" 
  ]; 

  @override
  void initState() {
    datePickedOrder = DateTime.now().toString();
    super.initState();
  }

  @override
  void dispose() {
    namaCustomerController.dispose();
    nomorResiController.dispose();
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
            body: ListView(
              padding: GlobalVariable.defaultPadding,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,                
                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text("Mohon atur terlebih dahulu data order yang akan dibuat", textAlign: TextAlign.center),
                      // Center(child: OutlinedButton(onPressed: (){
                      //   Get.to(() => const AddNewCustomer());
                      // }, child: const Text("Lengkapi Sekarang"))),
                      TextField(
                        controller: namaCustomerController,
                        readOnly: true,
                        onTap: () async {
                            customerController.getCustomer();
                            Get.defaultDialog(
                              backgroundColor: Colors.white,
                              title: "Daftar Customer",
                              titleStyle: kDefaultTextStyle(color: Colors.black, fontSize: 16),
                              titlePadding: const EdgeInsets.only(top: 15),
                              content: Obx(
                                () => customerController.isLoading.value ? Center(
                                  child: floatingLoading(),
                                ) : customerController.listCustomer.length == 0 ? Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(CupertinoIcons.person_2_square_stack, color: Colors.black,),
                                      Text("Tidak ada customer", style: kDefaultTextStyle(color: Colors.black),)
                                    ],
                                  ),
                                ) : SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        customerController.listCustomer.length, (index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 5),
                                              child: ListTile(
                                                tileColor: Colors.black12,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(7)
                                                ),
                                                dense: true,
                                                title: Text(customerController.listCustomer[index]['nama'] ?? 'Tidak ada nama', style: kDefaultTextStyle(color: Colors.black, fontSize: 14),),
                                                onTap: () async {
                                                  setState(() {
                                                    namaCustomerController.text = customerController.listCustomer[index]['nama'];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          }
                                      )
                                    ),
                                  ),
                                ),
                            );
                          },
                        decoration: InputDecoration(
                          label: Text("Nama Customer", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      TextField(
                        readOnly: true,
                        onTap: (){
                          randomString = getRandomString(20);
                            setState(() {
                              nomorResiController.text = randomString!;
                            });
                        },
                        controller: nomorResiController,
                        decoration: InputDecoration(
                          suffix: IconButton(
                            onPressed: (){
                            randomString = getRandomString(20);
                            setState(() {
                              nomorResiController.text = randomString!;
                            });
                          }, icon: const Icon(Icons.replay_circle_filled_rounded)),
                          label: Text("Nomor Resi", style: kDefaultTextStyle(fontSize: 16),),
                          labelStyle: kDefaultTextStyle(fontSize: 16),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(child: Text("Tanggal Order", style: kDefaultTextStyle(fontSize: 16),)),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2024), //get today's date
                                      firstDate:DateTime(2023), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now()
                                    );
                                    if(pickedDate != null ){                      
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      setState(() {
                                          datePickedOrder = formattedDate; //set foratted date to TextField value. 
                                      });
                                    }
                                  }, 
                                  icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), label: Text(DateFormat('dd/MM/yyyy').format(datePickedOrder != null ? DateTime.parse(datePickedOrder!) : DateTime.now()), style: kDefaultTextStyle(fontSize: 13),))
                              ],
                            ),
                          ),

                          Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(child: Text("Jatuh Tempo", style: kDefaultTextStyle(fontSize: 16),)),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2024), //get today's date
                                      firstDate:DateTime(2023), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now()
                                    );
                                    if(pickedDate != null ){                      
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                      setState(() {
                                          datePickedSampai = formattedDate; //set foratted date to TextField value. 
                                      });
                                    }
                                  }, 
                                  icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), label: Text(DateFormat('dd/MM/yyyy').format(datePickedOrder != null ? DateTime.parse(datePickedOrder!) : DateTime.now()), style: kDefaultTextStyle(fontSize: 13),))
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white60, 
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 0.3, color: Colors.white60),
                        ),
                        child: DropdownButton(
                          style: kDefaultTextStyle(fontSize: 16),
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          underline: const SizedBox(),
                          value: dropDownValueWeek,                           
                          icon: const Icon(Icons.keyboard_arrow_down),     
                          items: itemsLeverage.map((String items) { 
                            return DropdownMenuItem( 
                              value: items, 
                              child: Text(items, style: kDefaultTextStyle(),), 
                            ); 
                          }).toList(), 
                          onChanged: (String? newValue) {  
                            setState(() { 
                              dropDownValueWeek = newValue!; 
                              }); 
                            }, 
                          ),
                        ),
                    ]
                  ),
                ),
                const SizedBox(height: 15),
                kDeafultButton(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  textColor: Colors.white,
                  onPressed: (){
                    if(namaCustomerController.text == '' || randomString == null || datePickedSampai == null || dropDownValueWeek == 'Metode Pembayaran'){
                      Get.snackbar("Gagal", "Data tidak boleh kosong, Mohon periksa ulang", backgroundColor: Colors.white);
                    }else{
                      Get.to(() => PDFPreview(
                        metodePembayaran: dropDownValueWeek,
                        namaCustomer: namaCustomerController.text,
                        nomorPO: getRandomInt(20),
                        nomorResi: nomorResiController.text,
                        saldoJatuhTempo: formatCurrencyId.format(5000000),
                        tanggalJatuhTempo: datePickedSampai,
                      ));
                      setState(() {
                        showPreview = true;
                      });
                    }
                  },
                  title: "Print",
                  backgroundColor: Colors.blue
                ),
                // showPreview ? previewPDFContainer() : const SizedBox()
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Container previewPDFContainer(){
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/icons/icon_revisi.png', width: 30, height: 30,),
                  Text("Droidify Project", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                  Text("Indonesia", style: kDefaultTextStyle(fontWeight: FontWeight.normal),),
                  Text("admin@droidify.com", style: kDefaultTextStyle(fontWeight: FontWeight.normal),),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("FAKTUR", style: kDefaultTextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Text("#INV-284023", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                  Text("Saldo jatuh Tempo", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                  Text("IDR 5.000.000", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tanggal Faktur : $datePickedOrder"),
                    const Text("Ketentuan : Due on Receipt"),
                    Text("Tanggal Jatuh Tempo : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}"),
                    Text("No. PO : SO-${getRandomString(10)}"),
                    Text("No. Resi : $randomString"),
                    Text("Ditagih kepada : ${namaCustomerController.text}"),
                  ],
                ),
              ],
            ),
          ),
          randomString != null ? Container(
            padding: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.center,
            child: Column(
              children: [
                QrImageView(
                  data: randomString!,
                  version: QrVersions.auto,
                  size: 130.0,
                  semanticsLabel: "Droidfy",
                  errorStateBuilder: (cxt, err) {
                    return Container(
                      color: Colors.transparent,
                      child: const Center(
                        child: Text(
                          'Gagal generate QR Code',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
                Text("$randomString"),
              ],
            ),
          ) : 
        const SizedBox(),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  color: Colors.black
                ),
                children: [
                  TableCell(child: Text(" ID", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                  TableCell(child: Text(" Item & Deskripsi", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                  TableCell(child: Text(" Jumlah", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                  TableCell(child: Text(" Harga", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                  TableCell(child: Text(" Tarif", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                  TableCell(child: Text("Total", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                ]
              ),
              TableRow(
                children: [
                  TableCell(child: Text(" 1", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                  TableCell(child: Text(" NF-01", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                  TableCell(child: Text(" 10", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                  TableCell(child: Text(" 184.029", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                  TableCell(child: Text(" 13.000", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                  TableCell(child: Text("197.029", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                ]
              )
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Sub Total"),
                        Text("IDR68.000"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: Text("Metode Pembayaran", overflow: TextOverflow.clip)),
                        Text(dropDownValueWeek,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total", style: kDefaultTextStyle(fontWeight: FontWeight.bold)),
                        Text("IDR68.000", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Container(
                      color: Colors.grey.shade300,
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Saldo jatuh tempo", style: kDefaultTextStyle(fontWeight: FontWeight.bold)),
                        Text("IDR68.000", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                    )
                  ],
                ),
              )
            ],
          ),
          const Padding(
            padding:  EdgeInsets.symmetric(vertical: 20.0,horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Catatan*"),
                    Text("Terimakasih telah berbisnis dengan kami"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}