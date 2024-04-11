import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/data/sneaker_repository.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:sneakers_shop_app/utils/utils.dart';
import 'package:sneakers_shop_app/widgets/brand_picker.dart';

final homePageControllerProvider =
    AsyncNotifierProvider<HomePageController, List<Sneaker>>(
        () => HomePageController());

class HomePageController extends AsyncNotifier<List<Sneaker>> {
  @override
  FutureOr<List<Sneaker>> build() async {
    final sneakerRepo = ref.read(sneakerRepositroyProvider);
    final brandIndex = ref.read(brandIndexProvider);
    final brand = getBrandByIndex(brandIndex);

    return await sneakerRepo.getSneakersByBrand(brand);
  }

  Future<void> changeBrand(int index) async {
    final sneakerRepo = ref.read(sneakerRepositroyProvider);

    final brand = getBrandByIndex(index);
    state = await AsyncValue.guard(() {
      return sneakerRepo.getSneakersByBrand(brand);
    });
  }
}
