import 'package:flutter/material.dart';

Color colorPrimary = Color(0xFF4A4A4A);
Color colorSecondary = Color(0xFF333333);
Color colorPrimaryDarken = darken(colorPrimary, 10);
Color colorDefaultFont = Color(0xFF9A9A9A);
Color colorPlaceholder = Color(0xFFC4C4C4);
Color colorBackground = Color(0xFFF5F5F5);

Color darken(Color color, [int percent = 10]) {
  print(color.alpha);
  print(color.red);
  print(color.green);
  print(color.blue);
  assert(1 < percent && percent < 100,
      'percent harusl lebih kecil dari pada 100 dan lebih besar dari 1');
  var f = 1 - percent / 100;
  return Color.fromARGB(
    color.alpha,
    (color.red * f).round(),
    (color.green * f).round(),
    (color.blue * f).round(),
  );
}

Color brighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round());
}

// Padding & Margin
double defaultPadding = 20.0;

// font
const String fontFamily = 'Quicksand';

// small width
const smallWidth = 360;

// title
const String appTitle = "TAG";
