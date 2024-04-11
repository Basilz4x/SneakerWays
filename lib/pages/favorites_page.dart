import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/constants/colors_constant.dart';
import 'package:sneakers_shop_app/controllers/favorite_page_controller.dart';
import 'package:sneakers_shop_app/utils/build_context_extension.dart';
import 'package:sneakers_shop_app/widgets/custom_back_button.dart';
import 'package:sneakers_shop_app/widgets/favorite_sneaker_card.dart';

class FavortiesPage extends ConsumerWidget {
  const FavortiesPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final favoriteSneakersAsync = ref.watch(favoritePageControllerProvider);
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
          child: Column(
            children: [
              Row(
                children: [
                  const CustomBackButton(),
                  const SizedBox(
                    width: 76,
                  ),
                  Text(
                    "Favorites",
                    style: context.textTheme.headlineLarge!.copyWith(
                      color: AppColor.textColor,
                    ),
                  ),
                ],
              ),
              favoriteSneakersAsync.when(
                  data: (data) {
                    return data.isNotEmpty
                        ? Expanded(
                            child: GridView.builder(
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1,
                                ),
                                itemBuilder: (context, index) {
                                  return FavoriteSneakerCard(
                                    favoriteSneaker: data[index],
                                  );
                                }),
                          )
                        : Center(
                            child: Column(children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                  height: 235,
                                  width: 235,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Transform.scale(
                                    scale: 0.85,
                                    child: Image.asset(
                                        "lib/images/no_favorites.png"))
                              ]),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                "No Favorites",
                                style:
                                    context.textTheme.headlineMedium!.copyWith(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "You can go back and add a sneaker to your favorites by clicking the button",
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: AppColor.textColor.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Feedback.forTap(context);
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 200,
                                  height: 55,
                                  decoration: BoxDecoration(
                                      color: AppColor.secondaryColor,
                                      borderRadius: BorderRadius.circular(32)),
                                  child: Text(
                                    "Go Back",
                                    style:
                                        context.textTheme.titleLarge!.copyWith(
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          );
                  },
                  error: (e, stack) {
                    throw Exception("error in .when in FavoritesPage");
                  },
                  loading: () => const CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}
