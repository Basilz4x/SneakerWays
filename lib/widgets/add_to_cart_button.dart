import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/controllers/cart_pagE_controller.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:sneakers_shop_app/pages/sneaker_details_page.dart';

class AddToCartButton extends ConsumerWidget {
  const AddToCartButton({super.key, required this.sneaker});
  final Sneaker sneaker;

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        final colorSelcted = ref.read(colorSelectedProvider);
        ref.read(cartPageControllerProvider.notifier).addToCart(
            {"id": sneaker.id, "color": colorSelcted, "quantity": 1});
      },
      child: Container(
        height: 60,
        width: 84,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: AppColor.secondaryColor,
        ),
        child: const Icon(
          FontAwesomeIcons.basketShopping,
          color: AppColor.addToCartIconColor,
        ),
      ),
    );
  }
}
