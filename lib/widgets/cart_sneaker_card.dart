import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/data/sneaker_repository.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/cart_shimmer_sneaker_card.dart';

class CartSneakerCard extends ConsumerStatefulWidget {
  const CartSneakerCard(
      {super.key, required this.cartItem, required this.onRemoveFromCart});
  final Map<String, dynamic> cartItem;
  final void Function(Map<String, dynamic> sneakerCartItem, WidgetRef ref)
      onRemoveFromCart;

  @override
  ConsumerState<CartSneakerCard> createState() => _CartSneakerCardState();
}

class _CartSneakerCardState extends ConsumerState<CartSneakerCard> {
  bool finshed = false;
  late Sneaker sneaker;
  @override
  void initState() {
    mapToSneakerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return finshed
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: SizedBox(
              height: 125,
              child: Card(
                  elevation: 0,
                  color: AppColor.cardBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Container(
                          height: double.infinity,
                          width: 105,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: AppColor.backgroundColor,
                          ),
                          child: Transform.scale(
                            scale: 1.08,
                            child: Image.network(
                              _getImageFromColor(widget.cartItem["color"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  sneaker.name,
                                  style:
                                      context.textTheme.titleMedium!.copyWith(
                                    color: AppColor.textColor,
                                  ),
                                ),
                              ),
                              Text(
                                "men's shoes",
                                style: context.textTheme.titleSmall!.copyWith(
                                  color: AppColor.textColor.withOpacity(0.6),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Text(
                                    "\$${sneaker.price}",
                                    style: context.textTheme.titleMedium!
                                        .copyWith(
                                            color: AppColor.textColor,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  InputQty.int(
                                    initVal: widget.cartItem["quantity"],
                                    minVal: 1,
                                    decoration: QtyDecorationProps(
                                      width: 7,
                                      btnColor: AppColor.secondaryColor,
                                      isBordered: false,
                                      plusBtn: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColor.backgroundColor,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 20,
                                          color: AppColor.secondaryColor,
                                        ),
                                      ),
                                      minusBtn: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColor.backgroundColor,
                                        ),
                                        child: const Icon(
                                          Icons.remove,
                                          size: 20,
                                          color: AppColor.secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ))
        : const Center(
            child: CartShimmerSneakerCard(),
          );
  }

  String _getImageFromColor(String colorSelected) {
    for (var variant in sneaker.variants) {
      if (variant.color.contains(colorSelected)) {
        return variant.images[1];
      }
    }
    return "";
  }

  Future<void> mapToSneakerModel() async {
    sneaker = await ref
        .read(sneakerRepositroyProvider)
        .getSneakerById(widget.cartItem["id"]);

    setState(() {
      finshed = true;
    });
  }
}
