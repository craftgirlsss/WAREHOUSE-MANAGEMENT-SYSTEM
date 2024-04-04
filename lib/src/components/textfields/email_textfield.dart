import 'package:flutter/material.dart';
import 'package:warehouseapp/src/components/global_variable.dart';
import 'package:warehouseapp/src/components/textstyles/default_textstyle.dart';

class EmailTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  const EmailTextField({super.key, this.hintText, this.labelText, this.controller});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  bool? isEmail;
  @override
  void initState() {
    isEmail = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
       controller: widget.controller,
       style: kDefaultTextStyle(
          color: Colors.black,
          fontSize: 16
        ),
       cursorColor: GlobalVariable.mainColor,
       decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.black45),
        filled: false,
        prefixIcon: const Icon(Icons.email, color: GlobalVariable.mainColor),
        suffix: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500), 
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: GlobalVariable.mainColor,
              shape: BoxShape.circle),
            child: isEmail == false ? const Icon(Icons.close, color: Colors.white, size: 16) : const Icon(Icons.done, color: Colors.white, size: 16),    
          ),
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
          validateEmailBool(value: value);
       },
    );
  }

  bool? validateEmailBool({String? value}) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if(!regex.hasMatch(value!)){
      setState(() {
        isEmail = false;
      });
    }else{
      setState(() {
        isEmail = true;
      });
    }
    return isEmail;
  }
}