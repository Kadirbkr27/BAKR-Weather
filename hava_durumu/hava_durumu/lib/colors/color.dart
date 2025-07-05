import 'package:flutter/material.dart';

class AppColors {
  static const Color sunny = Color(0xFFFFF176); // sarı
  static const Color cloudy = Color(0xFF90A4AE); // gri
  static const Color rainy = Color(0xFF4FC3F7); // mavi
  static const Color snowy = Color(0xFFFFFFFF); // beyaz
  static const Color stormy = Color(0xFF616161); // koyu gri
  static const Color defaultColor = Color(0xFFE0E0E0); // varsayılan

  static Color getColorForWeather(String durum) {
    switch (durum.toLowerCase()) {
      case 'güneşli':
      case 'açık':
        return Colors.lightBlue.shade300;
      case 'bulutlu':
      case 'parçalı bulutlu':
      case 'az bulutlu':
        return Colors.blueGrey;
      case 'yağmurlu':
        return rainy;
      case 'karlı':
        return snowy;
      case 'fırtınalı':
        return stormy;
      default:
        return defaultColor;
    }
  }
}
