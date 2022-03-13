import 'package:flutter/material.dart';

class DTColors {
  DTColors._();

  static const Color white = Colors.white;
  static const Color grey = Colors.grey;

  static const MaterialColor primary = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color.fromRGBO(89, 52, 134, 0.1),
      100: Color.fromRGBO(89, 52, 134, 0.2),
      200: Color.fromRGBO(89, 52, 134, 0.3),
      300: Color.fromRGBO(89, 52, 134, 0.4),
      400: Color.fromRGBO(89, 52, 134, 0.5),
      500: Color.fromRGBO(89, 52, 134, 0.6),
      600: Color.fromRGBO(89, 52, 134, 0.7),
      700: Color.fromRGBO(89, 52, 134, 0.8),
      800: Color.fromRGBO(89, 52, 134, 0.9),
      900: Color.fromRGBO(89, 52, 134, 1),
    },
  );
  static const int _primaryValue = 0xFF593486;

  static const MaterialColor secondary = MaterialColor(
    _secondaryValue,
    <int, Color>{
      50: Color.fromRGBO(42, 178, 152, 0.1),
      100: Color.fromRGBO(42, 178, 152, 0.2),
      200: Color.fromRGBO(42, 178, 152, 0.3),
      300: Color.fromRGBO(42, 178, 152, 0.4),
      400: Color.fromRGBO(42, 178, 152, 0.5),
      500: Color.fromRGBO(42, 178, 152, 0.6),
      600: Color.fromRGBO(42, 178, 152, 0.7),
      700: Color.fromRGBO(42, 178, 152, 0.8),
      800: Color.fromRGBO(42, 178, 152, 0.9),
      900: Color.fromRGBO(42, 178, 152, 1),
    },
  );
  static const int _secondaryValue = 0xFF2AB298;
}
