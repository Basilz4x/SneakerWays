import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:sneakers_shop_app/pages/sneaker_details_page.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/utils/string_extension.dart';
import 'package:sneakers_shop_app/widgets/custom_bookmark_button.dart';

class SneakerCard extends StatelessWidget {
  const SneakerCard({super.key, required this.sneaker});
  final Sneaker sneaker;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        preloadImages(context, sneaker);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SneakerDetailsPage(
                  sneaker: sneaker,
                )));
      },
      child: SizedBox(
          width: double.infinity,
          height: 290,
          child: Card(
            elevation: 0,
            color: AppColor.cardBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sneaker.name.cutStringOverFlow(),
                                maxLines: 1,
                                style: context.textTheme.titleMedium!.copyWith(
                                    color: AppColor.textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rounded,
                                    color: AppColor.starColor,
                                  ),
                                  Text(
                                    "${sneaker.rating.value} (${sneaker.rating.reviewsNumber} Reviews)",
                                    style: context.textTheme.titleMedium!
                                        .copyWith(
                                            color: AppColor.textColor
                                                .withOpacity(0.43),
                                            fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    width: 300,
                    height: 200,
                    left: 20,
                    child: Transform.flip(
                      flipX: true,
                      child: Image.network(
                        sneaker.variants.first.images[1],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Text(
                      "\$${sneaker.price}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.titleMedium!.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CustomBookmarkButton(
                      sneaker: sneaker,
                      height: 50,
                      width: 50,
                      iconSize: 26,
                      withBorder: false,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void preloadImages(BuildContext context, Sneaker sneaker) {
    for (var variant in sneaker.variants) {
      precacheImage(NetworkImage(variant.images[0]), context);
    }
  }
}
