import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: 65,
        child: Card(
          elevation: 0,
          color: AppColor.iconBackgroundColor,
          child: TextField(
            cursorColor: AppColor.textColor,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              hintText: "Search your shoes",
              hintStyle: context.textTheme.bodyLarge!
                  .copyWith(color: AppColor.textColor.withOpacity(0.4)),
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColor.secondaryColor,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
