import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';

class FavoritePageController extends AsyncNotifier<List<Sneaker>> {
  @override
  FutureOr<List<Sneaker>> build() {
    return [];
  }

  Future<void> addOrRemoveFavorite(Sneaker sneakerFavItem) async {
    update((sneakers) {
      final listOfSneaker = sneakers;
      final sneaker = sneakerFavItem;
      final indexSneaker = sneakers
          .indexWhere((sneakerInList) => sneakerInList.id == sneaker.id);
      if (indexSneaker != -1) {
        listOfSneaker.remove(sneakerFavItem);
      } else {
        listOfSneaker.add(sneakerFavItem);
      }
      return listOfSneaker;
    });
  }
}

final favoritePageControllerProvider =
    AsyncNotifierProvider<FavoritePageController, List<Sneaker>>(
        FavoritePageController.new);
