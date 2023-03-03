import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:otus_food/models/comment_adapter.dart';
import 'package:otus_food/models/recipe_adapter.dart';
import 'package:otus_food/screens/home_screen.dart';
import 'package:otus_food/theme_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:otus_food/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..registerAdapter(RecipeAdapter())
    ..registerAdapter(CommentAdapter());

  await Hive.openBox(Settings.recipeBox);

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
