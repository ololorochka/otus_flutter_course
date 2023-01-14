import 'package:flutter/material.dart';

ThemeData foodTheme() {
  final ThemeData theme = ThemeData();

  return theme.copyWith(
    scaffoldBackgroundColor: const Color(0xFFECECEC),
    colorScheme: theme.colorScheme.copyWith(
      primary: const Color(0xFF165932),
      secondary: const Color(0xFF2ECC71),
    ),
    textTheme: const TextTheme().copyWith(
      headline2: const TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.w500),
      headline3: const TextStyle(fontSize: 16.0, color: Color(0xFF2ECC71)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF2ECC71),
      unselectedItemColor: Color(0xFFCCCCCC),
    ),
  );
}
