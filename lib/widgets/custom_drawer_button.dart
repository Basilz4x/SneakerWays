import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';

class CustomDrawerButton extends StatelessWidget {
  const CustomDrawerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
            color: AppColor.iconBackgroundColor, shape: BoxShape.circle),
        child: const Icon(
          FontAwesomeIcons.bars,
          size: 22,
        ),
      ),
    );
  }
}
