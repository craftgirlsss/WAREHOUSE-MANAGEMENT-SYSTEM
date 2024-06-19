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