import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/widgets/skeleton.dart';

class ShimmerSneakerCard extends StatelessWidget {
  const ShimmerSneakerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
          height: 290,
          decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: const Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Skeleton(height: 22, width: 210)),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Skeleton(height: 22, width: 230)),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                      Spacer(),
                      Skeleton(height: 42, width: 42)
                    ],
                  ),
                  Skeleton(
                    height: 140,
                    width: 320,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Skeleton(
                      height: 22,
                      width: 75,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
