import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/widgets/skeleton.dart';

class CartShimmerSneakerCard extends StatelessWidget {
  const CartShimmerSneakerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Container(
          height: 115,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.cardBackgroundColor,
              borderRadius: BorderRadius.circular(12)),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                children: [
                  Skeleton(
                    height: double.infinity,
                    width: 110,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skeleton(height: 21, width: 180),
                      SizedBox(
                        height: 7,
                      ),
                      Skeleton(height: 18, width: 130),
                      Spacer(),
                      Row(children: [
                        Skeleton(height: 21, width: 60),
                        SizedBox(
                          width: 85,
                        ),
                        Skeleton(height: 18, width: 75)
                      ])
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
