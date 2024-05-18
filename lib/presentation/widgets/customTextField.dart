import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      required this.emailController,
      required this.hintText,
      required this.icon,
      this.isEmail = false,
      this.iconColor = Colors.lightGreen});

  final TextEditingController emailController;
  final String hintText;
  final IconData icon;
  final bool isEmail;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      controller: emailController,
      validator: (value){
        if(value == null || value == ""){
          return " ${hintText} can't be empty!";
        }
        return null; 
      },
      decoration: InputDecoration(
        hintText: "${hintText}",
        filled: true,
        fillColor: Colors.grey.shade100,
        prefixIcon: Icon(
          icon,
          color: iconColor,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
