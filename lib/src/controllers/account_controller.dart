import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:warehouseapp/src/components/global_variable.dart' as vars;

class AccountController extends GetxController{
  var isLoading = false.obs;
  var id = Supabase.instance.client.auth.currentUser?.id;
  var listContacts = [].obs;

  Future<bool> fetchLogin({String? email, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    try {
     await Supabase.instance.client.auth.signInWithPassword(email: email, password: password!);
      // print(result);
      prefs.setBool('loggedIn', true);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  getPersonContact() async {
    isLoading.value = true;
    try {
      List resultVendor = await vars.client
          .from('vendor')
          .select("*");

      List resultCustomer = await vars.client
          .from('customer')
          .select('*');

      listContacts.value = [];

      listContacts.addAll(resultCustomer.map((e) {
        final mapItem = Map<String, dynamic>.from(e);
        mapItem['type'] = 'customer';
        return mapItem;
      }).toList());

      listContacts.addAll(resultVendor.map((e) {
        final mapItem = Map<String, dynamic>.from(e);
        mapItem['type'] = 'vendor';
        return mapItem;
      }));

      // if(resultCustomer.isNotEmpty || resultVendor.isNotEmpty){
      //   listContacts.value = [];
      //   for(int i = 0; i < resultCustomer.length; i++){
      //     listContacts.add(resultCustomer[i]);
      //   }
      //   for(int i = 0; i < resultVendor.length; i++){
      //     listContacts.add(resultVendor[i]);
      //   }
      // }
      print("ini result all contact = $listContacts");
      print("ini result all contact = ${listContacts.length}");
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}