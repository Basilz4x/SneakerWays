import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getCart() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        return [];
      }

      final userId = currentUser.uid;
      final userDoc = await _firestore.collection("Users").doc(userId).get();

      if (userDoc.exists) {
        final cart = userDoc.data()?["cart"] ?? [];
        final mappedCart = _mapCart(cart);
        return mappedCart;
      }
      return [];
    } catch (e) {
      throw Exception("Error getting cart: $e");
    }
  }

  Future<void> addToCart(Map<String, dynamic> sneakerCartItem) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        return;
      }

      final userId = currentUser.uid;
      final userDoc = await _firestore.collection("Users").doc(userId).get();

      if (userDoc.exists) {
        final cart = userDoc.data()?["cart"] as List<dynamic>;
        final mappedCart = _mapCart(cart);
        final itemIndex = mappedCart.indexWhere((cartItem) {
          return cartItem["id"] == sneakerCartItem["id"] &&
              cartItem["color"] == sneakerCartItem["color"];
        });

        if (itemIndex != -1) {
          mappedCart[itemIndex]["quantity"] =
              mappedCart[itemIndex]["quantity"] + 1;
        } else {
          mappedCart.add(sneakerCartItem);
        }

        await userDoc.reference.update({"cart": mappedCart});
      }
    } catch (e) {
      throw Exception("Error adding to cart: $e");
    }
  }

  Future<void> removeFromCart(Map<String, dynamic> sneakerCartItem) async {
    try {
      final currentUser = _auth.currentUser;

      if (currentUser == null) {
        return;
      }
      final userId = currentUser.uid;
      final userDoc = await _firestore.collection("Users").doc(userId).get();
      if (userDoc.exists) {
        final cart = await getCart();
        final mappedCart = _mapCart(cart);

        mappedCart.removeWhere((cartItem) =>
            cartItem["id"] == sneakerCartItem["id"] &&
            cartItem["color"] == sneakerCartItem["color"]);
        await userDoc.reference.update({"cart": mappedCart});
      }
    } catch (e) {
      throw Exception("Error in removeFromCart $e");
    }
  }

  List<Map<String, dynamic>> _mapCart(List<dynamic> cart) {
    return cart.map((item) => item as Map<String, dynamic>).toList();
  }
}

final cartRepositroyProvider = Provider((ref) => CartRepository());
