import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/constants/app_contant.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/controllers/home_page_controller.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/brand_picker.dart';
import 'package:sneakers_shop_app/widgets/custom_drawer.dart';
import 'package:sneakers_shop_app/widgets/custom_search_bar.dart';
import 'package:sneakers_shop_app/widgets/shimmer_sneaker_card.dart';
import 'package:sneakers_shop_app/widgets/sneakers_listview.dart';
import 'package:sneakers_shop_app/widgets/top_part_home_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final sneakersAsync = ref.watch(homePageControllerProvider);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TopPartHomePage(),
              const SizedBox(
                height: 15,
              ),
              const Row(
                children: [
                  CustomSearchBar(),
                ],
              ),
              const BrandPicker(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Best offers",
                    style: context.textTheme.titleLarge!.copyWith(
                        color: AppColor.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "See all",
                    style: context.textTheme.titleMedium!.copyWith(
                      color: AppColor.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              sneakersAsync.when(
                data: (sneakers) {
                  return SneakersListView(sneakers: sneakers);
                },
                error: (e, stack) => throw Exception("error in .when $e"),
                loading: () => const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ShimmerSneakerCard(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
