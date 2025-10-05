import 'package:flutter/material.dart';

class ColorModel {
  final String statusWeight;
  final Color color;

  ColorModel({required this.statusWeight, required this.color});

  static List<ColorModel> getColorStatus() {
    return [
      ColorModel(
        statusWeight: "Weak",
        color: Color.fromARGB(255, 112, 215, 186),
      ),
      ColorModel(
        statusWeight: "Healthy",
        color: Color.fromARGB(210, 125, 239, 43),
      ),
      ColorModel(statusWeight: "Fat", color: Color.fromARGB(255, 255, 236, 64)),
      ColorModel(
        statusWeight: "Obese",
        color: Color.fromARGB(255, 255, 153, 64),
      ),
      ColorModel(
        statusWeight: "Morbidly Obese",
        color: Color.fromARGB(255, 255, 86, 64),
      ),
    ];
  }
}
