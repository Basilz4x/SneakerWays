import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';

class ProfileTextFormField extends StatelessWidget {
  const ProfileTextFormField({
    super.key,
    required this.controller,
    required this.icon,
    required this.keyboardType,
    required this.isDate,
    required this.obscure,
    required this.isEnabled,
  });
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isDate;
  final bool obscure;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        onTap: isDate
            ? () async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900, 1),
                    lastDate: DateTime.now());
                if (date != null) {
                  final formattedDate = DateFormat("yyyy-MM-dd").format(date);
                  controller.text = formattedDate;
                }
              }
            : null,
        controller: controller,
        keyboardType: keyboardType,
        enabled: isEnabled,
        obscureText: obscure,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.secondaryColor)),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          prefix: Padding(
              padding: const EdgeInsets.only(right: 76),
              child: Icon(
                icon,
                color: AppColor.secondaryColor,
                size: 25,
              )),
          contentPadding: const EdgeInsets.symmetric(horizontal: 35),
        ),
      ),
    );
  }
}
