import 'package:flutter/material.dart';

Widget buildTextFormField({
  required String label,
  required String hint,
  required TextEditingController controller,
  String? Function(String?)? validator,
  bool obscure = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      SizedBox(height: 8),
      TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[800],
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ],
  );
}
