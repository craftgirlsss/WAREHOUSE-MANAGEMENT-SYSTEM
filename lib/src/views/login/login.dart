import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
import 'package:warehouseapp/src/components/buttons/default_button.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/loadings/loading_page.dart';
import 'package:warehouseapp/src/components/loadings/loadings.dart';
import 'package:warehouseapp/src/components/textfields/email_textfield.dart';
import 'package:warehouseapp/src/components/textfields/password_textfield.dart';
import 'package:warehouseapp/src/controllers/account_controller.dart';
// import 'package:warehouseapp/src/helpers/focus_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AccountController accountController = Get.put(AccountController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = false;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            body: Stack(
              children: [
                backgroundColor(context),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height / 1.7,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(color: Colors.black54, width: 0.7), 
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.black26,
                          offset: Offset(0, 4)
                        )
                      ]                   
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          Image.asset("assets/icons/ic_launcher.png", width: 150),
                          const SizedBox(height: 30),
                          EmailTextField(
                            controller: emailController,
                            hintText: "Email",
                            labelText: "E-mail",
                          ),
                          const SizedBox(height: 15),
                          PasswordTextField(
                            controller: passwordController,
                            hintText: "Password",
                            labelText: "Kata Sandi",
                          ),
                          const SizedBox(height: 45),
                          SizedBox(
                            height: 55,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Obx(
                              () => kDeafultButton(
                                backgroundColor: GlobalVariable.buttonColor,
                                onPressed: accountController.isLoading.value == true ? (){} : () async {
                                  if(await accountController.fetchLogin(email: emailController.text, password: passwordController.text) == true){
                                    Get.to(() => const LoadingPage());
                                  }else{
                                    Get.snackbar("Gagal", "Gagal login");
                                  }
                                },
                                title: "Login",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(() => accountController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}