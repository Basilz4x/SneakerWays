import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/add_to_cart_button.dart';
import 'package:sneakers_shop_app/widgets/custom_back_button.dart';
import 'package:sneakers_shop_app/widgets/custom_bookmark_button.dart';
import 'package:sneakers_shop_app/widgets/custom_cart_button.dart';
import 'package:sneakers_shop_app/widgets/custom_color_button.dart';
import 'package:sneakers_shop_app/widgets/custom_size_button.dart';

final colorSelectedProvider = StateProvider.autoDispose((ref) => "");
final sizeSelectedProvider = StateProvider.autoDispose<double>((ref) => 9);

class SneakerDetailsPage extends ConsumerStatefulWidget {
  const SneakerDetailsPage({super.key, required this.sneaker});
  final Sneaker sneaker;

  @override
  ConsumerState<SneakerDetailsPage> createState() => _SneakerDetailsPageState();
}

class _SneakerDetailsPageState extends ConsumerState<SneakerDetailsPage> {
  bool pageFinshed = false;
  bool otherAnimationFinshed = false;
  final otherAnimationDuration = 500;
  final animationDurationSneaker = 650;

  @override
  void initState() {
    Future.microtask(() {
      ref
          .read(colorSelectedProvider.notifier)
          .update((state) => widget.sneaker.variants.first.color);

      setState(() {
        pageFinshed = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorSelected = ref.watch(colorSelectedProvider);
    final sizeSelected = ref.watch(sizeSelectedProvider);
    debugPrint(sizeSelected.toString());

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 65,
                        ),
                        AnimatedOpacity(
                          opacity: pageFinshed ? 1 : 0,
                          duration:
                              Duration(milliseconds: otherAnimationDuration),
                          onEnd: () {
                            setState(() {
                              otherAnimationFinshed = true;
                            });
                          },
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  widget.sneaker.name,
                                  style: context.textTheme.titleLarge!.copyWith(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  "${widget.sneaker.gender.name} shoes",
                                  style:
                                      context.textTheme.titleMedium!.copyWith(
                                    color: AppColor.textColor.withOpacity(0.43),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 100,
                      child: Transform.scale(
                        scale: widget.sneaker.brand.toLowerCase() == "reebok"
                            ? 2.6
                            : 1.3,
                        child: Image.asset(
                            "lib/images/${widget.sneaker.brand}-logo.png",
                            color: AppColor.cardBackgroundColor),
                      ),
                    ),
                    AnimatedPositioned(
                      duration:
                          Duration(milliseconds: animationDurationSneaker),
                      curve: Curves.easeOut,
                      top: 25,
                      right: pageFinshed && otherAnimationFinshed ? -200 : -650,
                      bottom: 0,
                      child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationZ(-pi / 10),
                          child: Transform.scale(
                            scale: 0.95,
                            child: Image.network(
                              _getImageFromColor(colorSelected),
                            ),
                          )),
                    ),
                    AnimatedPositioned(
                      top: 180,
                      right: pageFinshed ? 0 : -50,
                      duration: Duration(milliseconds: otherAnimationDuration),
                      child: Column(
                        children: [
                          Text(
                            "Fav",
                            style: context.textTheme.labelMedium!.copyWith(
                                color: AppColor.textColor,
                                fontWeight: FontWeight.bold),
                          ),
                          CustomBookmarkButton(
                            sneaker: widget.sneaker,
                            height: 46,
                            width: 46,
                            iconSize: 22,
                            withBorder: true,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 120,
                      left: 0,
                      right: 0,
                      child: AnimatedOpacity(
                        opacity: pageFinshed ? 1 : 0,
                        duration:
                            Duration(milliseconds: otherAnimationDuration),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\$${widget.sneaker.price}",
                                  style: context.textTheme.headlineMedium!
                                      .copyWith(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Price",
                                  style: context.textTheme.titleSmall!.copyWith(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ...widget.sneaker.variants
                                    .map((variant) => CustomColorButton(
                                          isSelected:
                                              colorSelected == variant.color
                                                  ? true
                                                  : false,
                                          colorName: variant.color,
                                        )),
                                Text(
                                  "Color",
                                  style: context.textTheme.titleSmall!.copyWith(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: otherAnimationDuration),
                      curve: Curves.easeOut,
                      bottom: pageFinshed ? 30 : -80,
                      right: 0,
                      left: 0,
                      child: Container(
                        width: double.infinity,
                        height: 75,
                        decoration: BoxDecoration(
                            color: AppColor.cardBackgroundColor,
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Add to Cart",
                              style: context.textTheme.titleLarge!.copyWith(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 90,
                            ),
                            AddToCartButton(
                              sneaker: widget.sneaker,
                            )
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBackButton(),
                          CustomCartButton(),
                        ],
                      ),
                    ),
                    AnimatedPositioned(
                      top: 180,
                      left: pageFinshed ? 0 : -50,
                      duration: Duration(milliseconds: otherAnimationDuration),
                      child: Column(children: [
                        Text(
                          "Size",
                          style: context.textTheme.labelMedium!.copyWith(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        ...widget.sneaker.variants[0].sizes.map(
                          (sizeStock) => CustomSizeButton(
                            sizeStock: sizeStock,
                            isSelected:
                                sizeSelected == sizeStock.size ? true : false,
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  String _getImageFromColor(String colorSelected) {
    for (var variant in widget.sneaker.variants) {
      if (variant.color.contains(colorSelected)) {
        return variant.images[0];
      }
    }
    return "";
  }
}
