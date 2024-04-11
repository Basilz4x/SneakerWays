import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        height: 47,
        width: 47,
        decoration: const BoxDecoration(
            color: AppColor.iconBackgroundColor, shape: BoxShape.circle),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 22,
        ),
      ),
    );
  }
}
