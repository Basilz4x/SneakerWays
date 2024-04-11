import 'package:flutter/material.dart';

int getIndexByBrand(String brand) {
  switch (brand.toLowerCase()) {
    case "puma":
      return 0;
    case "adidas":
      return 1;
    case "nike":
      return 2;
    case "jordan":
      return 3;
    case "reebok":
      return 4;
    default:
      return 2;
  }
}

String getBrandByIndex(int index) {
  switch (index) {
    case 0:
      return "puma";
    case 1:
      return "adidas";
    case 2:
      return "nike";
    case 3:
      return "jordan";
    case 4:
      return "reebok";
    default:
      return "nike";
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
