import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicPasswordTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onPress;
  final String hint;
  const BasicPasswordTextField({super.key, required this.controller, required this.obscure, required this.onPress, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: IconButton(
          onPressed: onPress,
          icon: Icon(obscure ? Icons.remove_red_eye : Icons.visibility_off),
        ),
      ),
    );
    ;
  }
}
