import 'dart:math';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/global_variable.dart' as vars;

class CustomerController extends GetxController {
  var isLoading = false.obs;
  var alamatTagihan = ''.obs;
  var kode_pos_alamat_tagihan = ''.obs;
  var urlPhotoSupabase = ''.obs;
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
      List? result = await vars.client.from('customer').insert(
        {
          'nama' : nama ?? 'Unknown name',
          'kode' : getRandomString(6),
          'no_telp' : phoneNumber ?? 'Unknown phone number',
          'email' : email ?? 'Not Set',
          'alamat' : alamat ?? 'Not Set',
          'nama_perusahaan' : namaPerusahaan ?? 'Unknown',
          'tipe_customer' : tipeCostumer ?? 'Perusahaan',
          'npwp' : npwp ?? '0',
          'alamat_tagihan' : alamatTagihan.value == '' ? 'Address not set' : alamatTagihan.value,
          'kode_pos_alamat_tagihan' : kode_pos_alamat_tagihan.value == '' ? 'Postal Code not set' : kode_pos_alamat_tagihan.value,
          'kode_pos_alamat_pengiriman' : alamatPengiriman.value == '' ? 'Address not set' : alamatPengiriman.value,
          'alamat_pengiriman' : kode_pos_alamat_pengiriman.value == '' ? 'Postal Code not set' : kode_pos_alamat_pengiriman.value
          }
        ).select();
      print(result);
      if(result.isEmpty){
        isLoading.value = false;
        return false;
      }
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
      print("ini result vendor $resultVendor");
      isLoading.value = false;
      return true;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> addVendor({String? nama, String? phone, String? email, String? alamat}) async {
    isLoading(true);
    try {
      List? result = await vars.client.from('vendor').insert([{
          'nama' : nama ?? 'Unknonwn name',
          'kode' : getRandomString(6),
          'no_telp' : phone ?? 'Unknown phone number',
          'email' : email ?? 'Email not set',
          'alamat' : alamat ?? 'Address not set'
        }]
      ).select();
      print(result);
      if(result.isEmpty){
        isLoading(false);
        return false;
      }
      isLoading(false);
      return true;
    } catch (e) {
      print(e);
      isLoading(false);
      return false;
    }
  }

  // Delete Vendor
  Future<bool> deleteVendor({int? id}) async {
    isLoading(true);
    try {
      List? result = await vars.client.from('vendor').update({
        'deleted' : true
      }).eq('id', id!)
      .select();
      print(result);
      isLoading(false);
      if(result.isEmpty){
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      isLoading(false);
      return false;
    }
  }

  // Delete Vendor
  Future<bool> deleteCustomer({int? id}) async {
    isLoading(true);
    try {
      List? result = await vars.client.from('customer').update({
        'deleted' : true
      }).eq('id', id!)
      .select();
      print(result);
      isLoading(false);
      if(result.isEmpty){
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      isLoading(false);
      return false;
    }
  }

  Future<bool> updateCustomer({int? id, String? name, String? phone}) async {
    isLoading(true);
    try {
      List? result = await vars.client.from('customer').update({
        'nama' : name,
        'no_telp' : phone
      }).eq('id', id!)
      .select();
      print(result);
      isLoading(false);
      if(result.isEmpty){
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      isLoading(false);
      return false;
    }
  }

  Future<bool> updateVendor({int? id, String? name, String? phone}) async {
    isLoading(true);
    try {
      List? result = await vars.client.from('customer').update({
        'nama' : name,
        'no_telp' : phone
      }).eq('id', id!)
      .select();
      print(result);
      isLoading(false);
      if(result.isEmpty){
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      isLoading(false);
      return false;
    }
  }

  // uploadImageProfile(context, {ImageSource? media}) async {
  //   isLoading.value = true;
  //   XFile? image;
  //   final ImagePicker picker = ImagePicker();
  //   var img = await picker.pickImage(source: media!);
  //   image = img;
  //   final avatarFile = File(image!.path);
  //   final fileExt = avatarFile.path.split('.').last;
  //   String? nameFile = "${DateTime.now().toIso8601String()} + $fileExt";
  //   try {
  //     await vars.client.storage.from('image_profile').upload('public/$nameFile', avatarFile, fileOptions: const FileOptions(cacheControl: '3600', upsert: false));
  //     var resultPulicURL = vars.client.storage.from('invoices').getPublicUrl('public/$nameFile');
  //     // print(resultPulicURL);
  //     String? fullURL = urlPhotoSupabase.value + resultPulicURL;
  //     await vars.client.from('cr_profiles').update({'url_profile': fullURL}).eq('user_uuid', id);
  //     isLoading.value = false;
  //   } catch (e) {
  //     print(e);
  //     isLoading.value = false;
  //   }
  //   isLoading.value = false;
  // }
}