import 'package:flutter/material.dart';

class TextFeild extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;

  const TextFeild({
    Key? key,
    required this.controller,
    required this.label,
    this.obscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
