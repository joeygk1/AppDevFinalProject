import 'package:flutter/material.dart';


Widget buildTextField({
  required String label,
  required String hint,
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
      TextField(
        obscureText: obscure,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[300],
          hintText: hint,
          hintStyle: TextStyle(color: Colors.lightBlueAccent),
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