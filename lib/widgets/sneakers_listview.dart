import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/models/sneaker.dart';
import 'package:sneakers_shop_app/widgets/sneaker_card.dart';

class SneakersListView extends StatelessWidget {
  const SneakersListView({super.key, required this.sneakers});
  final List<Sneaker> sneakers;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: sneakers.length,
        itemBuilder: (context, index) => SneakerCard(sneaker: sneakers[index]),
      ),
    );
  }
}
