import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/custom_bookmark_button.dart';

class FavoriteSneakerCard extends ConsumerStatefulWidget {
  const FavoriteSneakerCard({super.key, required this.favoriteSneaker});
  final Sneaker favoriteSneaker;

  @override
  ConsumerState<FavoriteSneakerCard> createState() =>
      _FavoriteSneakerCardState();
}

class _FavoriteSneakerCardState extends ConsumerState<FavoriteSneakerCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppColor.cardBackgroundColor,
          child: Stack(
            children: [
              Transform.translate(
                offset: const Offset(2, -10),
                child: Transform.scale(
                  scale: 1.1,
                  child: Image.network(
                    widget.favoriteSneaker.variants.first.images[0],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.favoriteSneaker.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: context.textTheme.titleMedium!.copyWith(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${widget.favoriteSneaker.price}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: context.textTheme.titleMedium!.copyWith(
                          color: AppColor.secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 5,
                  top: 5,
                  child: CustomBookmarkButton(
                    height: 42,
                    width: 42,
                    iconSize: 22,
                    withBorder: false,
                    sneaker: widget.favoriteSneaker,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
