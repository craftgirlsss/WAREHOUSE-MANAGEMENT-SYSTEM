import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class PDFPreview extends StatefulWidget {
  final String? metodePembayaran;
  final String? nomorResi;
  final String? nomorPO;
  final String? namaCustomer;
  final String? tanggalJatuhTempo;
  final String? saldoJatuhTempo;

  const PDFPreview({super.key, this.metodePembayaran, this.nomorResi, this.nomorPO, this.namaCustomer, this.saldoJatuhTempo, this.tanggalJatuhTempo});

  @override
  State<PDFPreview> createState() => _PDFPreviewState();
}

class _PDFPreviewState extends State<PDFPreview> {
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              WidgetsToImage(
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
                              Text("#INV-${DateFormat('ddMMyyyy').format(DateTime.now())}", style: kDefaultTextStyle(fontWeight: FontWeight.bold),),
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
                                    Text("${widget.metodePembayaran}"),
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
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              // bytes != null ? buildImage(bytes!) : const SizedBox(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          final bytes = await controller.capture();
          setState(() {
            this.bytes = bytes;
            File('${Directory('/storage/emulated/0/Download').path}/invoice-${DateTime.now()}.jpg').writeAsBytes(this.bytes!);
          });
        },
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }

  Widget buildImage(Uint8List bytes) => Image.memory(bytes);
}