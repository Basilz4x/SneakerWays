import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/controllers/favorite_page_controller.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';

class CustomBookmarkButton extends ConsumerWidget {
  const CustomBookmarkButton({
    super.key,
    required this.height,
    required this.width,
    required this.iconSize,
    required this.withBorder,
    required this.sneaker,
  });

  final double height;
  final double width;
  final double iconSize;
  final bool withBorder;

  final Sneaker sneaker;

  @override
  Widget build(BuildContext context, ref) {
    final favoriteList = ref.watch(favoritePageControllerProvider).valueOrNull;
    return GestureDetector(
      onTap: () {
        ref
            .read(favoritePageControllerProvider.notifier)
            .addOrRemoveFavorite(sneaker);
      },
      child: SizedBox(
        height: height,
        width: width,
        child: Card(
          shape: withBorder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: AppColor.secondaryColor,
                  ))
              : null,
          elevation: 0,
          color: AppColor.iconBackgroundColor,
          child: Icon(
            favoriteList == null
                ? Icons.bookmark_outline_rounded
                : favoriteList.contains(sneaker)
                    ? Icons.bookmark_rounded
                    : Icons.bookmark_outline_rounded,
            color: AppColor.secondaryColor,
            size: iconSize,
          ),
        ),
      ),
    );
  }
}
