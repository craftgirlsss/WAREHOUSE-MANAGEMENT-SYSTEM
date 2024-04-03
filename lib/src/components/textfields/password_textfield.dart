import 'package:flutter/material.dart';

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
       decoration: InputDecoration(
        hintText: widget.hintText,
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: const Icon(Icons.lock, color: Colors.white,),
        filled: false,
        suffix: GestureDetector(
          onTap: (){
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: obscureText == true ? const Icon(Icons.visibility, color: Colors.white) :  const Icon(Icons.visibility_off, color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isEightCharacter == false ? Colors.red : Colors.white
          )
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isEightCharacter == false ? Colors.red : Colors.white
          )
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isEightCharacter == false ? Colors.red : Colors.white
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