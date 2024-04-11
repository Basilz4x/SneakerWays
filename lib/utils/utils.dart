import 'package:flutter/material.dart';
import 'package:sneakers_shop_app/constants/app_contant.dart';

int getIndexByBrand(Brand brand) {
  switch (brand) {
    case Brand.puma:
      return 0;
    case Brand.adidas:
      return 1;
    case Brand.nike:
      return 2;
    case Brand.jordan:
      return 3;
    case Brand.reebok:
      return 4;
    default:
      return 2;
  }
}

String getBrandByIndex(int index) {
  switch (index) {
    case 0:
      return Brand.puma.name;
    case 1:
      return Brand.adidas.name;
    case 2:
      return Brand.nike.name;
    case 3:
      return Brand.jordan.name;
    case 4:
      return Brand.reebok.name;
    default:
      return Brand.nike.name;
  }
}

Color getColorByName(String colorName) {
  switch (colorName.toLowerCase()) {
    case "pink":
      return Colors.pink[100]!;
    case "grey":
      return Colors.grey;
    case "white":
      return Colors.white;
    case "black":
      return Colors.black;
    case "orange":
      return Colors.orange;
    case "brown":
      return Colors.brown;
    case "teal":
      return Colors.teal[200]!;
    case "purple":
      return Colors.purple;
    case "green":
      return Colors.green;
    case "blue":
      return Colors.blue[800]!;
    default:
      return Colors.indigo[100]!;
  }
}
