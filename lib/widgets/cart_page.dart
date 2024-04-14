import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/controllers/cart_pagE_controller.dart';
import 'package:sneakers_shop_app/data/cart_repository.dart';
import 'package:sneakers_shop_app/data/sneaker_repository.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/cart_sneaker_card.dart';
import 'package:sneakers_shop_app/widgets/custom_back_button.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  bool priceCalcFinshed = false;
  double totalPrice = 0;

  @override
  void initState() {
    _calculatePrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sneakersAsync = ref.watch(cartPageControllerProvider);

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  Text(
                    "My Cart",
                    style: context.textTheme.titleLarge!.copyWith(
                      color: AppColor.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                ],
              ),
              sneakersAsync.when(data: (data) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (dissDirection) {
                            _removeFromCart(data[index], ref);
                          },
                          child: CartSneakerCard(
                            cartItem: data[index],
                            onRemoveFromCart: _removeFromCart,
                          ),
                        );
                      }),
                );
              }, error: (e, stack) {
                return const SizedBox();
              }, loading: () {
                return const SizedBox();
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 63,
                        width: 170,
                        decoration: BoxDecoration(
                            color: AppColor.backgroundColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all()),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Total Price",
                              style: context.textTheme.titleSmall!.copyWith(
                                color: AppColor.textColor.withOpacity(0.5),
                              ),
                            ),
                            priceCalcFinshed
                                ? Text(
                                    "\$$totalPrice",
                                    style:
                                        context.textTheme.titleLarge!.copyWith(
                                      color: AppColor.textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const CircularProgressIndicator()
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 63,
                          width: 170,
                          decoration: BoxDecoration(
                              color: AppColor.secondaryColor,
                              borderRadius: BorderRadius.circular(14)),
                          child: Text(
                            "Buy Now",
                            style: context.textTheme.titleLarge!.copyWith(
                              color: AppColor.backgroundColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _removeFromCart(
      Map<String, dynamic> seankerCartItem, WidgetRef ref) async {
    priceCalcFinshed = false;

    await Future.wait([
      ref
          .read(cartPageControllerProvider.notifier)
          .removeFromCart(seankerCartItem)
    ]);
    _calculatePrice();
  }

  Future<void> _calculatePrice() async {
    totalPrice = 0;
    final cart = await ref.read(cartRepositroyProvider).getCart();
    if (cart.isEmpty) {
      setState(() {
        priceCalcFinshed = true;
      });
      return;
    }

    await Future.wait(cart.map((cartItem) async {
      int quantity = cartItem["quantity"] as int;

      final sneaker = await ref
          .read(sneakerRepositroyProvider)
          .getSneakerById(cartItem["id"] as String);
      totalPrice += quantity * sneaker.price;
    }).toList());

    setState(() {
      priceCalcFinshed = true;
    });
  }
}
