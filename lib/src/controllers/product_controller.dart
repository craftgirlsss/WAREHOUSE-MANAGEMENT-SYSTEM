import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:warehouseapp/src/models/category_models.dart';
import 'package:warehouseapp/src/models/product_models.dart';
import 'package:warehouseapp/src/components/global_variable.dart' as vars;

class ProductControllers extends GetxController {
  var isLoading = false.obs;
  var itemCountLength = 0.obs;
  var itemCountSelected = 0.obs;
  var itemNameSelected = ''.obs;
  var notesitemSelected = ''.obs;
  var vendorNameItemSelected = ''.obs;
  var priceBook = 0.obs;
  var dateItemSelected = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  var idItemSelected = 0.obs;
  var productModels = <ProductModels>[].obs;
  var soldModels = <SoldModels>[].obs;
  var purcashedHistoryModels = <PurcashedHistoryModels>[].obs;
  var categoryModels = <CategoryModels>[].obs;
  var resultInvoice = [].obs;
  var resultUpdateStockHistory = [].obs;
  var id = vars.client.auth.currentUser?.id;
  var totalSoldQuantities = 0.obs;
  var totalPurcashedQuantities = 0.obs;
  

  Future<bool> deleteItems(int id)async{
    try {
      isLoading(true);
      List? resultDeleteItem = await vars.client.from('item').update({'deleted' : true}).eq('id', id).select();
      print(resultDeleteItem);
      if(resultDeleteItem.isEmpty){
        isLoading(false);
        return false;
      }else if(resultDeleteItem.isNotEmpty){
        isLoading(false);
        return true;
      }else{
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      return false;
    }
  }

  Future<bool> getUpdateStockHistory() async {
    isLoading.value = true;
    try {
      List? result = await vars.client
          .from('history_update_stock')
          .select('*, item(*), vendor(*)');
      print(result);
      if(result.isNotEmpty){
        resultUpdateStockHistory.value = result;
        isLoading.value = false;
        return true;
      }
      isLoading.value = false;
      return false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> postHistoryUpdateStock({int? itemID, int? vendorID, String? notes, int? jumlahItem, int? totalHarga, String? transactionDate}) async {
    isLoading.value = true;
    try {
      List? resultUpdateStock = await vars.client
          .from('history_update_stock')
          .insert([
            {
              'vendor_id' : vendorID,
              'item_id' : itemID,
              'notes' : notes,
              'jumlah_item_update' : jumlahItem,
              'total_harga' : totalHarga,
              'transaction_date' : transactionDate
            }
          ])
          .select();
          print(resultUpdateStock);
          List? getTotalStockBuku = await vars.client.from('item').select('jumlah_stock_saat_ini').eq('id', itemID!).limit(1);
          print(getTotalStockBuku);
          int totalStockAfterOrder = 0;
          totalStockAfterOrder = getTotalStockBuku[0]['jumlah_stock_saat_ini'] + jumlahItem;
          print(totalStockAfterOrder);
          List? reesultUpdatStok = await vars.client.from('item').update({
            'jumlah_stock_saat_ini' : totalStockAfterOrder
          }).eq('id', itemID).select();
          print(reesultUpdatStok);
      
      // List? resultUpdateStockItem = await vars.client
      //     .from('item')
      //     .insert([
      //       {
      //         'item_id' : itemID,
      //         'jumlah_stock_saat_ini' : jumlahItem
      //       }
      //     ])
      //     .select();
      // // print(resultUpdateStockItem);
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> getCategoryItem() async {
    isLoading.value = true;
    try {
      List result = await vars.client
          .from('kategori')
          .select('*');
      // print(result);
      categoryModels.value = result.map((e) => CategoryModels.fromJson(e)).toList();
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> fetchProductItems() async {
    isLoading.value = true;
    try {
      List? result = await vars.client
          .from('item')
          .select('*, kategori(*)');
      print(result);
      if(result.isNotEmpty){
        productModels.value = result.map((e) => ProductModels.fromJson(e)).toList();
        itemCountLength.value = 0;
        for(int i = 0; i<productModels.length; i++){
          if(productModels[i].deleted == false){
            itemCountLength.value = itemCountLength.value + 1;
          }
        }
        isLoading.value = false;
        return true;
      }
      isLoading.value = false;
      return false;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> addProductItems({
    String? namaItem,
    int? hargaPenjaualan,
    String? penerbit,
    int? openingStock,
    String? namaPenerbitItem,
    int? hargaBeli,
    int? category
  }) async {
    isLoading.value = true;
    try {
      List? result = await vars.client
          .from('item')
          .insert({
            'nama' : namaItem,
            'jumlah_stock_saat_ini' : openingStock,
            'penerbit' : penerbit,
            'harga_jual' : hargaPenjaualan,
            'harga_beli' : hargaBeli,
            'kategori_id' : category
          })
          .select();
      if(result.isEmpty){
        isLoading.value = false;
        return false;
      }else if(result.isNotEmpty){
        isLoading.value = false;
        return true;
      }else{
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> editProductItems({
    String? namaItem,
    String? sku,
    int? hargaJual,
    int? hargaBeli,
    int? stok,
    String? namaPenerbitItem,
    int? category,
    int? id
  }) async {
    isLoading.value = true;
    try {
      List? result = await vars.client
          .from('item')
          .update({
            'nama': namaItem,
            'sku' : sku,
            'harga_beli' : hargaBeli,
            'jumlah_stock_saat_ini' : stok,
            'penerbit' : namaPenerbitItem,
            'kategori_id' : category,
            'harga_jual' : hargaJual
          })
          .eq('id', id!)
          .select();
      print("ini result update item $result");
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
    return false;
  }

  Future<bool> purchasedQuantities() async {
    isLoading.value = true;
    try {
      List? resultPurcashed = await vars.client
        .from('history_update_stock')
        .select('*');
        // print(resultPurcashed);
      if(resultPurcashed.isEmpty){
        isLoading(false);
        return false;
      }else{
        purcashedHistoryModels.value = resultPurcashed.map((value) => PurcashedHistoryModels.fromJson(value)).toList();
        for(int i = 0; i < resultPurcashed.length; i++){
          totalPurcashedQuantities.value = totalPurcashedQuantities.value + (purcashedHistoryModels[i].totalHarga ?? 0);
        }
        isLoading(false);
        return true;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> soldQuantities() async {
    isLoading(true);
    try {
      List? resultSoldQuantities = await vars.client.from('invoice_order').select('*');
      print(resultSoldQuantities);
      if(resultSoldQuantities.isEmpty){
        isLoading(false);
        return false;
      }else{
        soldModels.value = resultSoldQuantities.map((value) => SoldModels.fromJson(value)).toList();
        for(int i = 0; i < resultSoldQuantities.length; i++){
          totalSoldQuantities.value = totalSoldQuantities.value + (soldModels[i].totalTagihan ?? 0);
        }
        print(totalSoldQuantities.value);
        isLoading(false);
        return true;
      }
    } catch (e) {
      isLoading(false);
      return false;
    }
    // int totalPurcashedOrderItem = 0;
    // int totalSaleOrder = 0;
    // try {
    //   List resultPurcashedOrderItem = await vars.client
    //       .from('purchase_order_item')
    //       .select('quantity');

    //   List resultSaleOrder = await vars.client
    //       .from('sale_order')
    //       .select('total');
    //   // productModels.value = result.map((e) => ProductModels.fromJson(e)).toList();
    //   for(int i = 0; i<resultPurcashedOrderItem.length; i++){
    //     totalPurcashedOrderItem = resultPurcashedOrderItem[i]['quantity'];
    //   }

    //   for(int i = 0; i<resultSaleOrder.length; i++){
    //     totalSaleOrder = resultSaleOrder[i]['total'];
    //   }
      
    //   totalSoldQuantities.value = totalPurcashedOrderItem - totalSaleOrder;

    //   isLoading.value = false;
    // } catch (e) {
    //   print(e);
    //   isLoading.value = false;
    // }
  }


  Future<int> totalEarnings() async {
    int earning = 0;
    int totalEarning = 0;
    isLoading.value = true;
    try {
      List resultTotalEarnings = await vars.client
          .from('sale_order_item')
          .select('harga_total');
      // print("ini resultTotalEarnings $resultTotalEarnings");
      for(int i = 0; i < resultTotalEarnings.length; i++){
        earning = resultTotalEarnings[i]['harga_total'];
        totalEarning = totalEarning + earning;
      }
      isLoading.value = false;
      return totalEarning;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return 0;
    }
  }

  Future<int> totalSpendings() async {
    int spending = 0;
    int totalSpending = 0;
    isLoading.value = true;
    try {
      List resultTotalSpendings = await vars.client
          .from('purchase_order_item')
          .select('harga_total');
      // print("ini resulttotalSpendings $resultTotalSpendings");
      for(int i = 0; i < resultTotalSpendings.length; i++){
        spending = resultTotalSpendings[i]['harga_total'];
        totalSpending = totalSpending + spending;
      }
      isLoading.value = false;
      return totalSpending;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return 0;
    }
  }

  updateStock() async {
    isLoading.value = true;
    // int total = priceBook.value * itemCountSelected.value;
    try {
      List resultUpdateStock = await vars.client
          .from('item')
          .update({
            'jumlah_stock_saat_ini' : itemCountSelected.value
          })
          .eq('id', idItemSelected.value)
          .select();
      // print("ini result update stock $resultUpdateStock");

      // List resultTotalUpdateStock = await vars.client
      //     .from('purchase_order_item')
      //     .update({'quantity': itemCountSelected.value,
      //       'harga_per_item' : priceBook.value,
      //       'harga_total' : total
      //     })
      //     .eq('item_id', idItemSelected.value)
      //     .select();
      // print("ini resulttotalUpdateStock $resultTotalUpdateStock");
      // isLoading.value = false;
      // if(resultTotalUpdateStock.length == 0){
      //   Get.snackbar("Gagal", "Tidak ada buku yang dimaksud didalam tabel purchase order item", backgroundColor: Colors.white);
      // }else{
      //   Get.snackbar("Gagal", "Berhasil mengupdate stock buku", backgroundColor: Colors.white);
      // }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future<bool> addCategory({String? kodeBuku, String? judul}) async {
    isLoading.value = true;
    try {
      List? resultAddingCategory = await vars.client
        .from('kategori')
        .insert({
          'nama' : judul,
          'kode'  : kodeBuku
        })
        .select();
        // print("ini resulttotalUpdateStock $resultAddingCategory");
        isLoading.value = false;
      if(resultAddingCategory.isEmpty){
        Get.snackbar("Gagal", "Gagal menyimpan data ke tabel kategori",);
        return false;
      }else if(resultAddingCategory.isNotEmpty){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> deleteCategory({String? kodeBuku}) async {
    isLoading.value = true;
    try {
      List resultDeleteCategory = await vars.client
        .from('kategori')
        .delete()
        .eq('kode', kodeBuku!);
        print("ini resultDeleteCategory $resultDeleteCategory");
        isLoading.value = false;
      if(resultDeleteCategory.length == 0){
        Get.snackbar("Gagal", "Gagal mengahpus kategori dari tabel kategori",);
        return false;
      }else if(resultDeleteCategory.length > 0){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> orderInvoice({
    String? invoiceKode,
    int? itemID,
    String? nomorResi,
    int? customerID,
    int? tarif,
    String? tanggalOrder,
    String? tanggalTagihan,
    String? metodePembayaran,
    String? nomorPO,
    int? jumlahBuku,
    int? totalTagihan
  }) async {
    isLoading(true);
    try {
      List? result = await vars.client.from('invoice_order').insert(
        {
          'invoice_kode' : invoiceKode,
          'item_id' : itemID,
          'nomor_resi' : nomorResi,
          'customer_id' : customerID,
          'tarif' : tarif,
          'tanggal_order' : tanggalOrder,
          'tanggal_tagihan' : tanggalTagihan,
          'metode_pembayaran' : metodePembayaran,
          'nomor_po' : nomorPO,
          'jumlah_buku' : jumlahBuku,
          'total_tagihan' : totalTagihan
          }
        ).select();

      print(result);
      List? getTotalStockBuku = await vars.client.from('item').select('jumlah_stock_saat_ini').eq('id', itemID!).limit(1);
      print(getTotalStockBuku);
      int totalStockAfterOrder = 0;
      totalStockAfterOrder = getTotalStockBuku[0]['jumlah_stock_saat_ini'] - jumlahBuku;
      print(totalStockAfterOrder);
      List? reesultUpdatStok = await vars.client.from('item').update({
        'jumlah_stock_saat_ini' : totalStockAfterOrder
      }).eq('id', itemID).select();
      print(reesultUpdatStok);

      // print(reesultUpdatStok);
      // List? resultGetStock = await vars.client.from('item').select('jumlah_stock_saat_ini').eq('id', itemID!).limit(1);
      // print(resultGetStock);

      // int jumlahStockSaatIni = resultGetStock[0]['jumlah_stock_saat_ini'];

      // var totalStock = jumlahStockSaatIni - result[0]['jumlah_buku'];

      // List? updateStock = await vars.client.from('item').update({
      //   'jumlah_stock_saat_ini' : totalStock
      // }).select('jumlah_stock_saat_ini').select();

      // print(updateStock);
        
      if(result.isEmpty){
        return false;
      }
      print(result);
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }


  Future<bool> stockHistory() async {
    isLoading.value = true;
    try {
      List resultData = await vars.client
          .from('invoice_order')
          .select('*, item(*, kategori(*)), customer(*)');
      // print(resultData);
      print("ini invoice models = $resultData");
      resultInvoice.value = resultData;
      if(resultData.isEmpty){
        print("masuk ke isempty");
        isLoading.value = false;
        return false;
      }else{
        isLoading.value = false;
        return true;
      }
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> updateStatusHistoryItem({
    int? status,
    int? id
  }) async {
    isLoading.value = true;
    try {
      await vars.client
          .from('invoice_order')
          .update({
            'status' : status
          })
          .eq('id', id!)
          .select();
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
    return false;
  }

  Future<int?> scanningQRCode({
    String? nomorResi
  }) async {
    isLoading.value = true;
    try {
      List? resultCheckStatus = await vars.client
          .from('invoice_order')
          .select('status')
          .eq('nomor_resi', nomorResi!)
          .limit(1);

      print(resultCheckStatus);
      isLoading.value = false;
      if(resultCheckStatus.isEmpty){
        return -2;
      }
      return resultCheckStatus[0]['status'];
    } catch (e) {
      print(e);
      isLoading.value = false;
      return null;
    }
  }

  var productResult = [].obs;
  Future<bool> selectProduct({
    int? id
  }) async {
    isLoading.value = true;
    try {
      List? resultProduct = await vars.client
          .from('item, kategori(*)')
          .select('*')
          .eq('id', id!)
          .limit(1);


      print(resultProduct);
      isLoading.value = false;
      if(resultProduct.isEmpty){
        return false;
      }
      productResult.value = resultProduct;        
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }
}

class SoldModels {
  int? id, itemID, customerID, tarif, jumlahBuku, totalTagihan, status;
  String? invoiceKode, createdAt, nomorResi, tanggalOrder, tanggalTagihan, metodePembayaran, imageURL, nomorPO;

  SoldModels({
      this.id,
      this.itemID,
      this.customerID,
      this.tarif,
      this.jumlahBuku,
      this.totalTagihan,
      this.status,
      this.invoiceKode,
      this.createdAt,
      this.nomorResi,
      this.tanggalOrder,
      this.imageURL,
      this.metodePembayaran,
      this.nomorPO,
      this.tanggalTagihan
    });

    factory SoldModels.fromJson(Map<String, dynamic> json){
      return SoldModels(
        id: json['id'],
        itemID: json['item_id'],
        customerID: json['customer_id'],
        tarif: json['tarif'],
        jumlahBuku: json['jumlah_buku'],
        totalTagihan: json['total_tagihan'],
        metodePembayaran: json['metode_pembayaran'],
        createdAt: json['created_at'],
        imageURL: json['image_url'],
        invoiceKode: json['invoice_kode'],
        nomorPO: json['nomor_po'],
        nomorResi: json['nomor_resi'],
        status: json['status'],
        tanggalOrder: json['tanggal_order'],
        tanggalTagihan: json['tanggal_tagihan']
      );
    }
}

class PurcashedHistoryModels {
  int? id, vendorID, itemID, jumlahItemUpdate, totalHarga;
  String? createdAt, notes, transactionDate;

  PurcashedHistoryModels({
      this.id,
      this.itemID,
      this.vendorID,
      this.jumlahItemUpdate,
      this.totalHarga,
      this.createdAt,
      this.notes,
      this.transactionDate
    });

  factory PurcashedHistoryModels.fromJson(Map<String, dynamic> json){
    return PurcashedHistoryModels(
      id: json['id'],
      itemID: json['item_id'],
      vendorID: json['vendor_id'],
      notes: json['notes'],
      createdAt: json['creted_at'],
      jumlahItemUpdate: json['jumlah_item_update'],
      totalHarga: json['total_harga'],
      transactionDate: json['transaction_date'],
    );
  }
}