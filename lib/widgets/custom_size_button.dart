import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:sneakers_shop_app/pages/sneaker_details_page.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';

class CustomSizeButton extends ConsumerWidget {
  const CustomSizeButton(
      {super.key, required this.sizeStock, required this.isSelected});
  final SizeStock sizeStock;
  final bool isSelected;
  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () {
        debugPrint("in class ${sizeStock.size}");
        ref
            .read(sizeSelectedProvider.notifier)
            .update((state) => sizeStock.size);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: SizedBox(
          height: 46,
          width: 46,
          child: Card(
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: AppColor.secondaryColor,
                ),
                borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            color:
                isSelected ? AppColor.secondaryColor : AppColor.backgroundColor,
            child: Center(
              child: Text(
                sizeStock.size.toString().split(".")[1].startsWith("0")
                    ? sizeStock.size.toString().split(".")[0]
                    : sizeStock.size.toString(),
                style: context.textTheme.titleSmall!.copyWith(
                  color: isSelected
                      ? AppColor.textColorSecondary
                      : AppColor.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
