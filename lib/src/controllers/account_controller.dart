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

  Future<int> getPersonContact() async {
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
      
      int lengthTotal = 0;
      for (var i = 0; i < listContacts.length; i++) {
        if(listContacts[i]['deleted'] == false){
          lengthTotal = lengthTotal + 1;
        }
      }
      isLoading.value = false;
      return lengthTotal;
    } catch (e) {
      print(e);
      isLoading.value = false;
      return 0;
    }
  }
}