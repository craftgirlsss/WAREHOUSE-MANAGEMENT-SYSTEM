class CategoryModels {
  int? id;
  String? kode;
  String? nama;

  CategoryModels({
    this.id,
    this.kode,
    this.nama
  });

  factory CategoryModels.fromJson(Map<String, dynamic> json){
    return CategoryModels(
      id: json['id'],
      kode: json['kode'],
      nama: json['nama']
    );
  }
}