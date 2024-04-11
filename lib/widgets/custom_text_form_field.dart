import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.obscure,
    required this.icon,
    required this.controller,
    this.validtor,
  });
  final String hint;
  final bool obscure;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validtor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: TextFormField(
        validator: validtor,
        controller: controller,
        obscureText: obscure,
        cursorColor: AppColor.textColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8),
          prefixIcon: Icon(icon),
          hintText: hint,
          helperText: "",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
