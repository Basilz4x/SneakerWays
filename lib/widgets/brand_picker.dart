import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sneakers_shop_app/constants/app_contant.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/controllers/home_page_controller.dart';
import 'package:sneakers_shop_app/utils/utils.dart';

final brandIndexProvider =
    StateProvider((ref) => getIndexByBrand(initialBrand));

class BrandPicker extends ConsumerStatefulWidget {
  const BrandPicker({super.key});

  @override
  ConsumerState<BrandPicker> createState() => _BrandPickerState();
}

class _BrandPickerState extends ConsumerState<BrandPicker> {
  final PageController _pageController = PageController(
      viewportFraction: 0.33, initialPage: getIndexByBrand(initialBrand));

  final double _chosenBrandHW = 90;
  final double _notChosenBrandHW = 50;
  final int _animationDuration = 150;

  @override
  Widget build(BuildContext context) {
    int brandIndex = ref.watch(brandIndexProvider);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut);
          },
          child: Icon(
            FontAwesomeIcons.caretLeft,
            color: AppColor.iconColor.withOpacity(0.4),
            size: 30,
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 120,
            child: ExpandablePageView(
              alignment: Alignment.center,
              onPageChanged: (value) {
                ref.read(brandIndexProvider.notifier).update((state) => value);
                ref
                    .read(homePageControllerProvider.notifier)
                    .changeBrand(value);
              },
              controller: _pageController,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(getIndexByBrand(Brand.puma),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linearToEaseOut);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    width: brandIndex == 0 ? _chosenBrandHW : _notChosenBrandHW,
                    height:
                        brandIndex == 0 ? _chosenBrandHW : _notChosenBrandHW,
                    decoration: BoxDecoration(
                      color: brandIndex == 0
                          ? AppColor.chosenBrandContainerColor
                          : AppColor.notChosenBrandContainerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.scale(
                      scale: 0.4,
                      child: Image.asset(
                        "lib/images/puma-logo.png",
                        color: brandIndex == 0
                            ? AppColor.chosenBrandImageColor
                            : AppColor.notChosenBrandImageColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(getIndexByBrand(Brand.adidas),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linearToEaseOut);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    width: brandIndex == 1 ? _chosenBrandHW : _notChosenBrandHW,
                    height:
                        brandIndex == 1 ? _chosenBrandHW : _notChosenBrandHW,
                    decoration: BoxDecoration(
                      color: brandIndex == 1
                          ? AppColor.chosenBrandContainerColor
                          : AppColor.notChosenBrandContainerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.scale(
                      scale: 0.70,
                      child: Image.asset(
                        "lib/images/adidas-logo.png",
                        color: brandIndex == 1
                            ? AppColor.chosenBrandImageColor
                            : AppColor.notChosenBrandImageColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(getIndexByBrand(Brand.nike),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linearToEaseOut);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    width: brandIndex == 2 ? _chosenBrandHW : _notChosenBrandHW,
                    height:
                        brandIndex == 2 ? _chosenBrandHW : _notChosenBrandHW,
                    decoration: BoxDecoration(
                      color: brandIndex == 2
                          ? AppColor.chosenBrandContainerColor
                          : AppColor.notChosenBrandContainerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.scale(
                      scale: 0.7,
                      child: Image.asset(
                        "lib/images/nike-logo.png",
                        color: brandIndex == 2
                            ? AppColor.chosenBrandImageColor
                            : AppColor.notChosenBrandImageColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(getIndexByBrand(Brand.jordan),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linearToEaseOut);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    width: brandIndex == 3 ? _chosenBrandHW : _notChosenBrandHW,
                    height:
                        brandIndex == 3 ? _chosenBrandHW : _notChosenBrandHW,
                    decoration: BoxDecoration(
                      color: brandIndex == 3
                          ? AppColor.chosenBrandContainerColor
                          : AppColor.notChosenBrandContainerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.scale(
                      scale: 0.65,
                      child: Image.asset(
                        "lib/images/jordan-logo.png",
                        color: brandIndex == 3
                            ? AppColor.chosenBrandImageColor
                            : AppColor.notChosenBrandImageColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(getIndexByBrand(Brand.reebok),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.linearToEaseOut);
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    width: brandIndex == 4 ? _chosenBrandHW : _notChosenBrandHW,
                    height:
                        brandIndex == 4 ? _chosenBrandHW : _notChosenBrandHW,
                    decoration: BoxDecoration(
                      color: brandIndex == 4
                          ? AppColor.chosenBrandContainerColor
                          : AppColor.notChosenBrandContainerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Transform.scale(
                      scale: 1.1,
                      child: Image.asset(
                        "lib/images/reebok-logo.png",
                        color: brandIndex == 4
                            ? AppColor.chosenBrandImageColor
                            : AppColor.notChosenBrandImageColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut);
          },
          child: Icon(
            FontAwesomeIcons.caretRight,
            color: AppColor.iconColor.withOpacity(0.4),
            size: 30,
          ),
        ),
      ],
    );
  }
}
