import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';

final sneakerRepositroyProvider = Provider((ref) => SneakerRepositroy());

class SneakerRepositroy {
  final _fireStore = FirebaseFirestore.instance;

  Future<List<Sneaker>> getSneakersByBrand(String brand) async {
    final querySnapShot = await _fireStore
        .collection("Sneakers")
        .where("brand", isEqualTo: brand)
        .get();
    final data = querySnapShot.docs
        .map((sneakerJson) => Sneaker.fromJson(sneakerJson.data()))
        .toList();
    return data;
  }

  Future<List<Sneaker>> getAllSneakers() async {
    final querySnapShot = await _fireStore.collection("Sneakers").get();
    final data = querySnapShot.docs
        .map((queryDoc) => Sneaker.fromJson(queryDoc.data()))
        .toList();
    return data;
  }

  Future<Sneaker> getSneakerById(String cartItemId) async {
    final allSneakers = await getAllSneakers();
    final sneaker =
        allSneakers.firstWhere((sneaker) => sneaker.id.contains(cartItemId));
    return sneaker;
  }

  Future<List<Sneaker>> searchForSneakrs(String searchQuery) async {
    final sneakerSnapshot = await _fireStore
        .collection("Sneakers")
        .where("name", isEqualTo: searchQuery)
        .get();

    final mappedSneakers = sneakerSnapshot.docs
        .map((queryDoc) => Sneaker.fromJson(queryDoc.data()))
        .toList();

    return mappedSneakers;
  }
}
