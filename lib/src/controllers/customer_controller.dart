import 'dart:math';

import 'package:get/get.dart';
import 'package:warehouseapp/src/components/global_variable.dart' as vars;

class CustomerController extends GetxController {
  var isLoading = false.obs;
  var alamatTagihan = ''.obs;
  var kode_pos_alamat_tagihan = ''.obs;
  var alamatPengiriman = ''.obs;
  var kode_pos_alamat_pengiriman = ''.obs;
  var listCustomer = [].obs;
  var listVendor = [].obs;

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(
    Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
    )
  );

  Future<bool> addCustomer({
    String? nama,
    String? namaPerusahaan,
    String? email,
    String? alamat,
    String? phoneNumber,
    String? npwp,
    String? tipeCostumer
  }) async {
    isLoading(true);

    try {
      List result = await vars.client.from('customer').insert(
        {
          'nama' : nama,
          'kode' : getRandomString(6),
          'no_telp' : phoneNumber,
          'email' : email,
          'alamat' : alamat,
          'nama_perusahaan' : namaPerusahaan,
          'tipe_customer' : tipeCostumer ?? 'perusahaan',
          'npwp' : npwp,
          'alamat_tagihan' : alamatTagihan.value,
          'kode_pos_alamat_tagihan' : kode_pos_alamat_tagihan.value,
          'kode_pos_alamat_pengiriman' : alamatPengiriman.value,
          'alamat_pengiriman' : kode_pos_alamat_pengiriman.value
          }
        ).select();
      print(result);
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }


  Future<bool> getCustomer() async {
    isLoading(true);
    try {
      listCustomer = [].obs;
      List resultCustomer = await vars.client.from('customer').select('*');
      listCustomer.addAll(resultCustomer.map((e) {
        final mapItem = Map<String, dynamic>.from(e);
        mapItem['type'] = 'customer';
        return mapItem;
      }).toList());
      print(resultCustomer);
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> getVendor() async {
    isLoading(true);
    try {
      List resultVendor = await vars.client.from('vendor').select('*');
      listVendor.value = [];
      listVendor.addAll(resultVendor.map((e) {
        final mapItem = Map<String, dynamic>.from(e);
        mapItem['type'] = 'vendor';
        return mapItem;
      }).toList());
      print(resultVendor);
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  
}