import 'package:flutter/material.dart';

class FoodTheme {
  static const Color _mainColor = Color(0xFF165932);
  static const Color _accentColor = Color(0xFF2ECC71);
  static const Color _backgroundColor = Color(0xFFECECEC);
  static const Color _canvasColor = Colors.white;
  static const Color _textColor = Colors.black;

  static ThemeData getTheme() {
    final ThemeData theme = ThemeData();

    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: _canvasColor,
        iconTheme: IconThemeData(
          color: _textColor,
        ),
        titleTextStyle: TextStyle(color: _mainColor, fontSize: 20),
        shadowColor: Color(0x40000000),
      ),
      scaffoldBackgroundColor: _backgroundColor,
      colorScheme: theme.colorScheme.copyWith(
        primary: _mainColor,
        secondary: _accentColor,
      ),
      textTheme: const TextTheme().copyWith(
        headline1: const TextStyle(fontSize: 16.0, color: _textColor, fontWeight: FontWeight.w400),
        headline2: const TextStyle(fontSize: 24.0, color: _textColor, fontWeight: FontWeight.w500),
        headline3: const TextStyle(fontSize: 16.0, color: _accentColor),
        headline4: const TextStyle(fontSize: 16.0, color: _mainColor, fontWeight: FontWeight.w500),
        headline5: const TextStyle(fontSize: 14.0, color: _textColor, fontWeight: FontWeight.w500),
        headline6: TextStyle(fontSize: 13.0, color: theme.colorScheme.neutralColor4, fontWeight: FontWeight.w400),
        bodyText1: const TextStyle(fontSize: 13.0, color: _mainColor, fontWeight: FontWeight.w400),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _canvasColor,
        selectedItemColor: _accentColor,
        unselectedItemColor: theme.colorScheme.neutralColor3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(232, 48)),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
          backgroundColor: MaterialStateProperty.all(_mainColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(232, 48)),
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
          side: MaterialStateProperty.all(const BorderSide(color: _mainColor, width: 4)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}

extension FoodColorScheme on ColorScheme {
  Color get canvasColor => Colors.white;
  Color get neutralColor => const Color(0xFFECECEC);
  Color get neutralColor1 => const Color(0xFFF0EEEE);
  Color get neutralColor2 => const Color(0xFFCCCCCC);
  Color get neutralColor3 => const Color(0xFFC2C2C2);
  Color get neutralColor4 => const Color(0xFF797676);
  Color get neutralColor5 => const Color(0xFF4D4D4D);
  Color get neutralColor6 => const Color(0xFF1B1B1B);
  Color get textColor => Colors.black;
  Color get notableColor => const Color(0xFFE54D3C);
}
