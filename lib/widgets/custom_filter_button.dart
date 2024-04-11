import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';

class CustomFilterButton extends StatelessWidget {
  const CustomFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 65,
      width: 70,
      child: Card(
        elevation: 0,
        color: AppColor.iconBackgroundColor,
        child: Icon(
          Icons.tune_rounded,
          size: 28,
        ),
      ),
    );
  }
}
