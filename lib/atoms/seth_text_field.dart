import 'package:flutter/material.dart';

class SethTextField extends StatelessWidget {
  const SethTextField({
    super.key,
    required this.label,
    this.controller,
    this.onFieldSubmitted,
    this.keyboardType,
  });

  final String label;
  final TextEditingController? controller;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        floatingLabelStyle: const TextStyle(height: 0.5),
        label: Center(child: Text(label)),
      ),
    );
  }
}
