import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:warehouseapp/src/components/appbars/default_appbar.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:warehouseapp/src/controllers/product_controller.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class PDFPreview extends StatefulWidget {
  final String? metodePembayaran;
  final int? customerID;
  final int? itemID;
  final int? totalTagihan;
  final String? nomorResi;
  final String? nomorPO;
  final String? namaCustomer;
  final String? tanggalJatuhTempo;
  final String? saldoJatuhTempo;
  final String? totalPembayaran;
  final String? biaya;
  final String? hargaBuku;
  final int? jumlahBuku;
  final String? judulBuku;
  final String? kodeBuku;
  final String? totalSemua;

  const PDFPreview({super.key, this.metodePembayaran, this.nomorResi, this.nomorPO, this.namaCustomer, this.saldoJatuhTempo, this.tanggalJatuhTempo, this.totalPembayaran, this.biaya, this.hargaBuku, this.jumlahBuku, this.judulBuku, this.kodeBuku, this.totalSemua, this.customerID, this.itemID, this.totalTagihan});

  @override
  State<PDFPreview> createState() => _PDFPreviewState();
}

class _PDFPreviewState extends State<PDFPreview> {
  WidgetsToImageController controller = WidgetsToImageController();
  ProductControllers productControllers = Get.put(ProductControllers());
  Uint8List? bytes;
  String? invoiceKode; 


  @override
  void initState() {
    invoiceKode = DateFormat('ddMMyyyyss').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: kDefaultAppBar(context, title: "Image Preview"),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 0)
                        )
                      ]
                    ),
                    child: WidgetsToImage(
                      controller: controller,
                      child: Container(
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
                                    Text("#INV-$invoiceKode", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                                    Text("Saldo jatuh Tempo", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                                    Text("${widget.saldoJatuhTempo}", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
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
                                      Text("Tanggal Faktur : ${DateFormat("dd/MM/yyyy").format(DateTime.now())}"),
                                      const Text("Ketentuan : Due on Receipt"),
                                      Text("Tanggal Jatuh Tempo : ${widget.tanggalJatuhTempo}"),
                                      Text("No. PO : SO-${widget.nomorPO}"),
                                      Text("No. Resi : ${widget.nomorResi}"),
                                      Text("Ditagih kepada : ${widget.namaCustomer}"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  QrImageView(
                                    data: widget.nomorResi!,
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
                                  Text("${widget.nomorResi}"),
                                ],
                              ),
                            ),
                            Table(
                              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                              children: [
                                TableRow(
                                  decoration: const BoxDecoration(
                                    color: Colors.black
                                  ),
                                  children: [
                                    TableCell(child: Text("ID", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                                    TableCell(child: Text("Item & Deskripsi", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                                    TableCell(child: Text("Jumlah", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                                    TableCell(child: Text("Harga", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                                    TableCell(child: Text("Tarif", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                                    TableCell(child: Text("Total", style: kDefaultTextStyle(color: Colors.white, fontSize: 10))),
                                  ]
                                ),
                                TableRow(
                                  children: [
                                    TableCell(child: Text("1", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                                    TableCell(child: Text(widget.judulBuku ?? 'A/N', textAlign: TextAlign.start,style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                                    TableCell(child: Text("${widget.jumlahBuku ?? 0}", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                                    TableCell(child: Text("${widget.hargaBuku ?? 0}", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                                    TableCell(child: Text("${widget.biaya ?? 0}", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
                                    TableCell(child: Text("${widget.totalPembayaran ?? 0}", style: kDefaultTextStyle(color: Colors.black, fontSize: 10))),
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Expanded(child: Text("Metode Pembayaran", overflow: TextOverflow.clip)),
                                          Text(widget.metodePembayaran ?? "Belum ada"),
                                        ],
                                      ),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Biaya Admin Transfer"),
                                          Text("IDR6.500"),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total", style: kDefaultTextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.totalSemua ?? 0}", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      Container(
                                        color: Colors.grey.shade300,
                                        child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Saldo jatuh tempo", style: kDefaultTextStyle(fontWeight: FontWeight.bold)),
                                          Text("${widget.totalSemua ?? 0}", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // bytes != null ? buildImage(bytes!) : const SizedBox(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                onPressed: productControllers.isLoading.value ? (){} : () async {
                  final bytes = await controller.capture();
                  setState(() {
                    this.bytes = bytes;
                  });
                  bool dirDownloadExists = true;
                  String androidDirectory = "/storage/emulated/0/Download/";
                  dirDownloadExists = await Directory(androidDirectory).exists();
                  if(dirDownloadExists){
                    androidDirectory = "/storage/emulated/0/Download";
                  }else{
                    androidDirectory = "/storage/emulated/0/Downloads";
                  }
              
                  final path = Platform.isAndroid ? androidDirectory : (await getApplicationDocumentsDirectory()).path;
                  final file = File('$path/invoice-book-${DateTime.now().microsecond}.jpg');
                  if(await productControllers.orderInvoice(
                    customerID: widget.customerID,
                    invoiceKode: invoiceKode,
                    itemID: widget.itemID,
                    jumlahBuku: widget.jumlahBuku,
                    metodePembayaran: widget.metodePembayaran,
                    nomorPO: "SO-${widget.nomorPO}",
                    nomorResi: widget.nomorResi,
                    totalTagihan: widget.totalTagihan,
                    tanggalOrder: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    tanggalTagihan: widget.tanggalJatuhTempo,
                    tarif: int.parse(widget.biaya!.split(RegExp(r"(\.+)"))[0]),
                  )){
                    await file.writeAsBytes(this.bytes!, flush: true).then((value) {
                      Get.snackbar("Invoice disimpan", "Invoice telah disimpan di folder Download", backgroundColor: Colors.white);
                      Future.delayed(const Duration(seconds: 2), (){
                        // Get.off(() => const MainPage());
                        Navigator.pop(context);
                      });
                    });

                  }
                },
                child: const Text("Submit and Save", style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        ),
        Obx(() => productControllers.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }

  Widget buildImage(Uint8List bytes) => Image.memory(bytes);
}