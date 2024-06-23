class CustomerModels {
  int? id;
  String? createdAt, kode, nama, noTelp, email, alamat, tipeCustomer, namaPerusahaan, npwp, alamatTagihan, kodePosAlamatTagihan, alamatPengiriman, kodePosAlamatPengiriman;

  CustomerModels({
    this.id,
    this.createdAt,
    this.kode,
    this.nama,
    this.email,
    this.alamat,
    this.tipeCustomer,
    this.namaPerusahaan,
    this.npwp,
    this.alamatPengiriman,
    this.alamatTagihan,
    this.kodePosAlamatPengiriman,
    this.kodePosAlamatTagihan,
    this.noTelp
  });

  factory CustomerModels.fromJson(Map<String, dynamic> json) {
    return CustomerModels(
      id: json['id'],
      createdAt: json['created_at'],
      kode: json['kode'],
      nama: json['nama'],
      email: json['email'],
      alamat: json['alamat'],
      tipeCustomer: json['tipe_customer'],
      namaPerusahaan: json['nama_perusahaan'],
      npwp: json['npwp'],
      alamatPengiriman: json['alamat_pengiriman'],
      alamatTagihan: json['alamat_tagihan'],
      kodePosAlamatPengiriman: json['kode_pos_alamat_pengiriman'],
      kodePosAlamatTagihan: json['kode_pos_alamat_tagihan'],
      noTelp: json['no_telp'],
    );
  }
}