import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/widgets/cart_page.dart';

class CustomCartButton extends ConsumerWidget {
  const CustomCartButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageTransition(
          child: const CartPage(),
          type: PageTransitionType.scale,
          alignment: Alignment.topRight,
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
        ));
      },
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
              height: 47,
              width: 47,
              decoration: const BoxDecoration(
                color: AppColor.iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Transform.scale(
                scale: 0.65,
                child: Image.asset(
                  "lib/images/shopping-bag.png",
                ),
              )),
        ],
      ),
    );
  }
}
