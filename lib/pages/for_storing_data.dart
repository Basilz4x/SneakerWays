import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:uuid/uuid.dart';

class ForStroingData extends StatelessWidget {
  const ForStroingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              storeData();
            },
            child: const Text("click to add")),
      ),
    );
  }
}

Future<void> removeData() async {
  final fireStore = FirebaseFirestore.instance;

  final QuerySnapshot querySnapshot = await fireStore
      .collection("Sneakers")
      .where("brand", isEqualTo: "Adidas")
      .get();

  querySnapshot.docs.forEach((doc) async {
    await doc.reference.delete();
  });
}

Future<void> storeData() async {
  final fireStore = FirebaseFirestore.instance;
  final dataJson = getSneaker.toJson();
  await fireStore.collection("Sneakers").add(dataJson);
}

Sneaker get getSneaker {
  return Sneaker(
      id: const Uuid().v4(),
      name: "Club C 85 Shoe",
      description: "",
      brand: "reebok",
      price: 459.00,
      gender: Gender.men,
      rating: Rating(value: 4.5, reviewsNumber: 1080),
      variants: [
        Variant(
          color: "white",
          images: [
            "https://i.ibb.co/YLNWTYk/4-1.png",
            "https://i.ibb.co/sPs734L/4-2.png",
          ],
          sizes: [
            SizeStock(size: 9, stock: 10),
            SizeStock(size: 9.5, stock: 10),
            SizeStock(size: 10, stock: 10),
            SizeStock(size: 10.5, stock: 10),
          ],
        ),
      ]);
}
