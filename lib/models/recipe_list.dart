import 'package:hive/hive.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/settings.dart';

// Список рецептов
class RecipeList {
  RecipeList._();
  static final RecipeList _singleton = RecipeList._();
  factory RecipeList() => _singleton;

  List<Recipe> items = [];

  // из хранилища
  Future<List<Recipe>> get() async {
    Box box = Hive.box(Settings.recipeBox);

    for (var id in box.keys) {
      var recipe = await box.get(id);
      if (recipe is Recipe) {
        items.add(recipe);
      }
    }
    if (items.isEmpty) {
      return Future.error(Exception());
    }
    return items;
  }

  // из json
  Future<List<Recipe>> getFromJson(Map<String, dynamic> json) async {
    Box box = Hive.box(Settings.recipeBox);

    for (var map in (json['recipe_list'] as List)) {
      Recipe recipe = Recipe.fromMap(map);
      items.add(recipe);
      box.put(recipe.recipeId, recipe);
    }
    if (items.isEmpty) {
      return Future.error(Exception());
    }
    return items;
  }
}
