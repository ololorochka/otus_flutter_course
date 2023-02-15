import 'package:flutter/material.dart';
import 'package:otus_food/screens/home_screen.dart';
import 'package:otus_food/theme_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otus Food',
      theme: FoodTheme.getTheme(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
