import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountController extends GetxController{
  var isLoading = false.obs;
  var id = Supabase.instance.client.auth.currentUser?.id;

  Future<bool> fetchLogin({String? email, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value = true;
    try {
      await Supabase.instance.client.auth.signInWithPassword(email: email, password: password!);
      prefs.setBool('loggedIn', true);
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }
}