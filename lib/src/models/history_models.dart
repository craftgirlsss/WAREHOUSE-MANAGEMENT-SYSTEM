import 'package:warehouseapp/src/models/customer_models.dart';
import 'package:warehouseapp/src/models/product_models.dart';

class InvoiceModels {
  ProductModels? itemID;
  CustomerModels? customerID;
  int? id, jumlahBuku, totalTagihan, status, tarif;
  String? createdAt, invoiceKode, nomorResi, tanggalOrder, tanggalTaghan, nomorPO, metodePembayaran;

  InvoiceModels({
    this.id,
    this.itemID,
    this.customerID,
    this.jumlahBuku,
    this.totalTagihan,
    this.status,
    this.tarif,
    this.createdAt,
    this.invoiceKode,
    this.nomorResi,
    this.tanggalOrder,
    this.tanggalTaghan,
    this.nomorPO,
    this.metodePembayaran
  });

  factory InvoiceModels.fromJson(Map<String, dynamic> json) {
    return InvoiceModels(
      id: json['id'],
      invoiceKode: json['invoice_kode'],
      createdAt: json['created_at'],
      itemID: json['item_id'] != null ? ProductModels.fromJson(json['item_id']) : json['item_id'],
      nomorResi: json['nomor_resi'],
      customerID: json['customer_id'] != null ? CustomerModels.fromJson(json['customer_id']) : json['customer_id'],
      tarif: json['tarif'],
      tanggalOrder: json['tanggal_order'],
      tanggalTaghan: json['tanggal_tagihan'],
      metodePembayaran: json['metode_pembayaran'],
      nomorPO: json['nomor_po'],
      jumlahBuku: json['jumlah_buku'],
      totalTagihan: json['total_tagihan'],
      status: json['status'] 
    );
  }
}