import 'package:get/get.dart';
import 'package:warehouseapp/src/models/category_models.dart';
import 'package:warehouseapp/src/models/product_models.dart';
import 'package:warehouseapp/src/components/global_variable.dart' as vars;

class ProductControllers extends GetxController {
  var isLoading = false.obs;
  var productModels = <ProductModels>[].obs;
  var categoryModels = <CategoryModels>[].obs;
  var id = vars.client.auth.currentUser?.id;
  var totalSoldQuantities = 0.obs;
  var totalPurcashedQuantities = 0.obs;

  Future<bool> getCategoryItem() async {
    isLoading.value = true;
    try {
      List result = await vars.client
          .from('kategori')
          .select('*');
      print(result);
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

  fetchProductItems() async {
    isLoading.value = true;
    try {
      List result = await vars.client
          .from('item')
          .select('*, kategori(*)');
      productModels.value = result.map((e) => ProductModels.fromJson(e)).toList();
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future<bool> addProductItems({
    String? namaItem,
    String? sku,
    int? hargaPenjaualan,
    String? penerbit,
    int? openingStock,
    String? namaPenerbitItem,
    int? category
  }) async {
    isLoading.value = true;
    try {
      List result = await vars.client
          .from('item')
          .insert({
            'nama' : namaItem,
            'stock_awal' : openingStock,
            'penerbit' : penerbit,
            'harga_jual' : hargaPenjaualan,
            'sku' : sku,
            'kategori_id' : category
          })
          .select();
      print(result);
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
    return false;
  }

  purchasedQuantities() async {
    isLoading.value = true;
    try {
      List resultPurchasedQuantities = await vars.client
          .from('purchase_order_item')
          .select('quantity');

      for(int i = 0; i<resultPurchasedQuantities.length; i++){
        totalPurcashedQuantities.value = resultPurchasedQuantities[i]['quantity'];
      }
      
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  soldQuantities() async {
    isLoading.value = true;
    int totalPurcashedOrderItem = 0;
    int totalSaleOrder = 0;
    try {
      List resultPurcashedOrderItem = await vars.client
          .from('purchase_order_item')
          .select('quantity');

      List resultSaleOrder = await vars.client
          .from('sale_order')
          .select('total');
      // productModels.value = result.map((e) => ProductModels.fromJson(e)).toList();
      for(int i = 0; i<resultPurcashedOrderItem.length; i++){
        totalPurcashedOrderItem = resultPurcashedOrderItem[i]['quantity'];
      }

      for(int i = 0; i<resultSaleOrder.length; i++){
        totalSaleOrder = resultSaleOrder[i]['total'];
      }
      
      totalSoldQuantities.value = totalPurcashedOrderItem - totalSaleOrder;

      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}