import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String text;
  bool obscureText;
  TextInputType keyboardType;
  Widget prefixIcon;
  Function(String) onChange;
  String? Function(String?) validate;
  MyTextField(
      {super.key,
      required this.text,
      this.obscureText = false,
      required this.keyboardType,
      required this.prefixIcon,
      required this.onChange,
      required this.validate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        onChanged: onChange,
        obscureText: obscureText,
        scrollPhysics: ScrollPhysics(),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: text,
          hintStyle: TextStyle(
            fontSize: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xFFF7F6F6),
        ),
        validator: validate,
        keyboardType: keyboardType,
      ),
    );
  }
}
