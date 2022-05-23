import 'package:flutter/material.dart';

class HotelAppTheme {
  ThemeData hotelAppTheme = ThemeData(
      primaryColor: const Color.fromARGB(255, 147, 233, 223),
      fontFamily: "Nunito",
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 27,
        ),
        headline2: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        headline3: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 158, 202, 207));
}
