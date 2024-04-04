import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';

class PasswordTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  const PasswordTextField({super.key, this.hintText, this.labelText, this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool? isEightCharacter;
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
       controller: widget.controller,
       obscureText: obscureText,
       cursorColor: GlobalVariable.mainColor,
       style: kDefaultTextStyle(fontSize: 16, color: Colors.black),
       decoration: InputDecoration(
        hintText: widget.hintText,
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.black45),
        prefixIcon: const Icon(Icons.lock, color: GlobalVariable.mainColor),
        filled: false,
        suffix: GestureDetector(
          onTap: (){
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: obscureText == true ? const Icon(Icons.visibility, color: GlobalVariable.mainColor) :  const Icon(Icons.visibility_off, color: GlobalVariable.mainColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariable.mainColor,
            width: 1.5
          )
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariable.mainColor,
            width: 1.5
          )
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: GlobalVariable.mainColor,
            width: 1.5
          )
        )
       ),
       onChanged: (value) {
          if(value.length < 8){
            setState(() {
              isEightCharacter = false;
            });
          }else{
            setState(() {
              isEightCharacter = true;
            });
          }
       },
    );
  }
}