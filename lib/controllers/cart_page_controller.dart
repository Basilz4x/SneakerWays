import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/data/cart_repository.dart';

class CartPageController extends AsyncNotifier<List<Map<String, dynamic>>> {
  @override
  Future<List<Map<String, dynamic>>> build() async {
    final cart = await ref.read(cartRepositroyProvider).getCart();

    return cart;
  }

  Future<void> addToCart(
      Map<String, dynamic> sneakerWithColorAndQunatity) async {
    final currentCart = state.valueOrNull;

    if (currentCart != null) {
      state = await AsyncValue.guard(() async {
        await ref
            .read(cartRepositroyProvider)
            .addToCart(sneakerWithColorAndQunatity);
        final cart = await ref.read(cartRepositroyProvider).getCart();
        return update((s) => cart);
      });
    }
  }

  Future<void> removeFromCart(
      Map<String, dynamic> sneakerWithColorAndQunatity) async {
    final currentCart = state.valueOrNull;

    if (currentCart != null) {
      state = await AsyncValue.guard(() async {
        await ref
            .read(cartRepositroyProvider)
            .removeFromCart(sneakerWithColorAndQunatity);
        final cart = await ref.read(cartRepositroyProvider).getCart();

        return update((s) => cart);
      });
    }
  }
}

final cartPageControllerProvider =
    AsyncNotifierProvider<CartPageController, List<Map<String, dynamic>>>(
        CartPageController.new);
