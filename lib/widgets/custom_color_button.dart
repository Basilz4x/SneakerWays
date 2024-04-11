import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/pages/sneaker_details_page.dart';
import 'package:sneakers_shop_app/utils/utils.dart';

class CustomColorButton extends ConsumerWidget {
  const CustomColorButton(
      {super.key, required this.colorName, required this.isSelected});
  final String colorName;
  final bool isSelected;
  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        ref.read(colorSelectedProvider.notifier).update((state) => colorName);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: SizedBox(
          height: 46,
          width: 46,
          child: Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isSelected == true
                      ? AppColor.secondaryColor
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            color: AppColor.backgroundColor,
            child: Center(
                child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  color: getColorByName(colorName),
                  borderRadius: BorderRadius.circular(4),
                  border: colorName.toLowerCase() == "white"
                      ? Border.all(color: Colors.black, width: 0.7)
                      : null),
            )),
          ),
        ),
      ),
    );
  }
}
