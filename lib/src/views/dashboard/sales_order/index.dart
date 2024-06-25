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
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:warehouseapp/src/helpers/currencies/format_currency.dart';
import 'package:warehouseapp/src/helpers/focus/focus_manager.dart';
import 'package:warehouseapp/src/helpers/random_string.dart';
import 'package:warehouseapp/src/views/dashboard/sales_order/pdf_preview.dart';
import 'package:warehouseapp/src/views/dashboard/update_stock/adding_contact_page.dart';

class SalesOrderPage extends StatefulWidget {
  const SalesOrderPage({super.key});

  @override
  State<SalesOrderPage> createState() => _SalesOrderPageState();
}

class _SalesOrderPageState extends State<SalesOrderPage> {
  final _formKey = GlobalKey<FormState>();
  CustomerController customerController = Get.put(CustomerController());
  ProductControllers productControllers = Get.put(ProductControllers());
  TextEditingController namaCustomerController = TextEditingController();
  TextEditingController nomorResiController = TextEditingController();
  TextEditingController namaBuku = TextEditingController();
  TextEditingController jumlahBuku = TextEditingController();
  TextEditingController tarif = TextEditingController();
  String? realCurrency;
  int? customerID;
  int? itemID;
  static const _locale = 'id';
  String _formatNumber(String s) => NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency => NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;
  String? randomString;
  int hargaBuku = 0;
  int totalStockBukuIni = 0;
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
    tarif.dispose();
    jumlahBuku.dispose();
    namaBuku.dispose();
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
            body: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
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
                              backgroundColor: Colors.black,
                              title: "Daftar Customer",
                              titleStyle: kDefaultTextStyle(color: Colors.white, fontSize: 16),
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
                                      Text("Tidak ada customer", style: kDefaultTextStyle(color: Colors.black),),
                                      TextButton(onPressed: (){
                                        Get.to(() => const AddingContactPage());
                                      }, child: const Text("Tambah Customer", style: TextStyle(color: Colors.white),))
                                    ],
                                  ),
                                ) : Container(
                                  color: Colors.transparent,
                                  width: 200,
                                  height: 300,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    children: List.generate(
                                      customerController.listCustomer.length , (index) {
                                        if(customerController.listCustomer[index]['deleted'] == true){
                                          return Container();
                                        }else{
                                          // if(index == customerController.listCustomer.length){
                                          //   return TextButton(onPressed: (){
                                          //     Navigator.pop(context);
                                          //     Get.to(() => const AddingContactPage());
                                          //   }, child: const Text("Tambah Customer", style: TextStyle(color: Colors.white),));
                                          // }
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 5),
                                              child: ListTile(
                                                tileColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(7)
                                                ),
                                                dense: true,
                                                title: Text(customerController.listCustomer[index]['nama'] ?? 'Tidak ada nama', style: kDefaultTextStyle(color: Colors.black, fontSize: 14),),
                                                onTap: () async {
                                                  setState(() {
                                                    namaCustomerController.text = customerController.listCustomer[index]['nama'];
                                                    customerID = customerController.listCustomer[index]['id'];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          }
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
                            suffix: GestureDetector(
                                onTap: (){
                                randomString = getRandomString(20);
                                setState(() {
                                  nomorResiController.text = randomString!;
                                });
                              },
                                child: const Icon(Icons.sync_outlined),
                            ),
                            label: Text("Nomor Resi", style: kDefaultTextStyle(fontSize: 16),),
                            labelStyle: kDefaultTextStyle(fontSize: 16),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))
                          ),
                        ),
                        const SizedBox(height: 15),
                        namaBuku.text != "" ? Text("Jumlah stok buku ${namaBuku.text} berjumlah $totalStockBukuIni") : Container(),
                        TextField(
                          readOnly: true,
                          onTap: (){
                            productControllers.fetchProductItems();
                            Get.defaultDialog(
                              backgroundColor: Colors.black,
                              title: "Daftar Buku",
                              titleStyle: kDefaultTextStyle(color: Colors.white, fontSize: 16),
                              titlePadding: const EdgeInsets.only(top: 15),
                              content: Obx(
                                () => productControllers.isLoading.value ? Center(
                                  child: floatingLoading(),
                                ) : productControllers.productModels.length == 0 ? Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(CupertinoIcons.person_2_square_stack, color: Colors.white,),
                                      Text("Tidak ada daftar buku", style: kDefaultTextStyle(color: Colors.white),)
                                    ],
                                  ),
                                ) : Container(
                                  padding: const EdgeInsets.all(10),
                                  width: 300,
                                  height: 300,
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                      children: List.generate(productControllers.productModels.length, (index) {
                                          if(productControllers.productModels[index].deleted == true){
                                            return Container();
                                          }
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 5),
                                              child: ListTile(
                                                tileColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(7)
                                                ),
                                                dense: true,
                                                title: Text(productControllers.productModels[index].nama ?? 'Tidak ada nama', style: kDefaultTextStyle(color: Colors.black, fontSize: 14),),
                                                onTap: () async {
                                                  setState(() {
                                                    itemID = productControllers.productModels[index].id;
                                                    totalStockBukuIni = productControllers.productModels[index].jumlahStockSaatIni ?? 0;
                                                    namaBuku.text = productControllers.productModels[index].nama ?? '';
                                                    hargaBuku = productControllers.productModels[index].hargaJual ?? 0;
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
                          controller: namaBuku,
                          decoration: InputDecoration(
                            label: Text("Pilih Buku", style: kDefaultTextStyle(fontSize: 16),),
                            labelStyle: kDefaultTextStyle(fontSize: 16),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))
                          ),
                        ),
                        TextFormField(
                          onTap: (){
                          },
                          keyboardType: TextInputType.number,
                          controller: jumlahBuku,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if(totalStockBukuIni == 0){
                              return 'Mohon pilih buku';
                            }else{
                              if(value != ''){
                                if(int.parse(value!) > totalStockBukuIni){
                                  return "Stok tidak mencukupi";
                                }else{
                                  return "";
                                }
                              }
                              return '';
                            }
                          },
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            label: Text("Jumlah Buku", style: kDefaultTextStyle(fontSize: 16),),
                            labelStyle: kDefaultTextStyle(fontSize: 16),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))
                          ),
                        ),
                        TextField(
                          onTap: (){
                          },
                          keyboardType: TextInputType.number,
                          controller: tarif,
                          decoration: InputDecoration(
                            prefixText: _currency,
                            label: Text("Tarif", style: kDefaultTextStyle(fontSize: 16),),
                            labelStyle: kDefaultTextStyle(fontSize: 16),
                              border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))
                          ),
                          onChanged: (string) {
                            realCurrency = string.replaceAll('.', '');
                            string = _formatNumber(string.replaceAll('.', ''));
                            tarif.value = TextEditingValue(
                              text: string,
                              selection: TextSelection.collapsed(offset: string.length),
                            );
                          },
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
                                        initialDate: DateTime.now(), //get today's date
                                        firstDate:DateTime(2023), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2030)
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
                                        initialDate: DateTime.now(), //get today's date
                                        firstDate:DateTime(2024), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2030)
                                      );
                                      if(pickedDate != null ){                      
                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        setState(() {
                                            datePickedSampai = formattedDate; //set foratted date to TextField value. 
                                        });
                                      }
                                    }, 
                                    icon: const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20,), label: Text(DateFormat('dd/MM/yyyy').format(datePickedSampai != null ? DateTime.parse(datePickedSampai!) : DateTime.now()), style: kDefaultTextStyle(fontSize: 13),))
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
                      if(namaCustomerController.text == '' || randomString == null || datePickedSampai == null || dropDownValueWeek == 'Metode Pembayaran' || int.parse(jumlahBuku.text) > totalStockBukuIni){
                        Get.snackbar("Gagal", "Data tidak boleh kosong", backgroundColor: Colors.white);
                      }else{
                        Get.to(() => PDFPreview(
                          customerID: customerID,
                          itemID: itemID,
                          kodeBuku: "NF-",
                          metodePembayaran: dropDownValueWeek,
                          namaCustomer: namaCustomerController.text,
                          nomorPO: getRandomInt(20),
                          nomorResi: nomorResiController.text,
                          saldoJatuhTempo: formatCurrencyId.format(5000000),
                          tanggalJatuhTempo: datePickedSampai,
                          biaya: tarif.text,
                          totalTagihan: (hargaBuku * int.parse(jumlahBuku.text)) + int.parse(realCurrency!),
                          hargaBuku: formatCurrencyId.format(int.parse(hargaBuku.toString())).toString(),
                          judulBuku: namaBuku.text,
                          jumlahBuku: int.parse(jumlahBuku.text),
                          totalPembayaran: formatCurrencyId.format((hargaBuku * int.parse(jumlahBuku.text)) + int.parse(realCurrency!)),
                          totalSemua: formatCurrencyId.format((hargaBuku * int.parse(jumlahBuku.text)) + int.parse(realCurrency!) + 6500),
                        ));
                        namaBuku.clear();
                        nomorResiController.clear();
                        jumlahBuku.clear();
                        totalStockBukuIni = 0;
                        tarif.clear();
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
        ),
      ],
    );
  }
}