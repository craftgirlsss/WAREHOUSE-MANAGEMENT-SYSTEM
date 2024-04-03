import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:warehouseapp/src/components/backgrounds/background_color.dart';
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
          onTap: (){},
          child: Scaffold(
            body: Stack(
              children: [
                backgroundColor(context),
                Center(
                  child: ClipRect(
                    child:  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child:  Container(
                        padding: const EdgeInsets.all(30),
                        width: MediaQuery.of(context).size.width - 50,
                        height: MediaQuery.of(context).size.height / 1.5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(26),                    
                        ),
                        child: Form(
                          child: Column(
                            children: [
                              const FlutterLogo(size: 120),
                              const SizedBox(height: 30),
                              EmailTextField(
                                controller: emailController,
                                hintText: "Masukkan email anda",
                                labelText: "E-mail",
                              ),
                              const SizedBox(height: 15),
                              PasswordTextField(
                                controller: passwordController,
                                hintText: "Masukkan password anda",
                                labelText: "Kata Sandi",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
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