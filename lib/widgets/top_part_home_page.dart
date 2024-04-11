import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/data/location_service.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/custom_cart_button.dart';
import 'package:sneakers_shop_app/widgets/custom_drawer_button.dart';
import '../constants/colors_constant.dart';

class TopPartHomePage extends ConsumerWidget {
  const TopPartHomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationAsync = ref.watch(userLocationProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomDrawerButton(),
            Column(
              children: [
                Text(
                  "Store Location",
                  style: context.textTheme.bodyMedium!.copyWith(),
                ),
                locationAsync.when(
                    data: (data) => Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 20,
                            ),
                            Text(
                              "${data.locality}, ${data.country}",
                              style: context.textTheme.bodyLarge!.copyWith(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                    error: (e, stack) => const SizedBox(),
                    loading: () => const SizedBox())
              ],
            ),
            const CustomCartButton(),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "Welcome,",
          style: context.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColor.textColor.withOpacity(0.4)),
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
            text: "Find Your Best ",
            style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold, color: AppColor.textColor),
          ),
          TextSpan(
            text: "Shoes!",
            style: context.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold, color: AppColor.secondaryColor),
          )
        ]))
      ],
    );
  }
}
