class ProductModels {
  int? id, stockAwal, stockMinimal, hargaJual, hargaBeli, jumlahStockSaatIni;
  String? nama, keterangan, createdAt, sku, penerbit;
  Kategori? toko;
  bool? deleted;
  

  ProductModels(
      {this.id,
      this.nama,
      this.stockMinimal,
      this.penerbit,
      this.stockAwal,
      this.hargaBeli,
      this.hargaJual,
      this.createdAt,
      this.keterangan,
      this.toko,
      this.deleted,
      this.sku,
      this.jumlahStockSaatIni
      });

  factory ProductModels.fromJson(Map<String, dynamic> json) {
    return ProductModels(
        id: json['id'],
        sku: json['sku'],
        penerbit: json['penerbit'],
        nama: json['nama'] ?? '-',
        stockMinimal: json['stock_minimal'],
        stockAwal: json['stock_awal'] ?? 0,
        hargaBeli: json['harga_beli'],
        hargaJual: json['harga_jual'],
        deleted: json['deleted'],
        jumlahStockSaatIni: json['jumlah_stock_saat_ini'],
        createdAt: json['created_at'].toString(),
        keterangan: json['keterangan'] ?? '0',
        toko: json['kategori'] != null
            ? Kategori.fromJson(json['kategori'])
            : json['kategori']);
  }
}

class Kategori {
  String? kode, nama;
  int? id;

  Kategori({
    this.id,
    this.kode,
    this.nama
  });

  factory Kategori.fromJson(Map<String?, dynamic> json) {
    return Kategori(
      id: json['id'],
      nama: json['nama'],
      kode: json['kode']
    );
  }
}
