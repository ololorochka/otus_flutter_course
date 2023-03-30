import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/models/recipe_list.dart';
import 'package:otus_food/settings.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

// Контроллер списка рецептов
class RecipeListController {
  static Future<List<Recipe>> loadRecipeList() async {
    final Dio dio = Dio();

    if (!await FlutterNetworkConnectivity().isInternetConnectionAvailable()) {
      return RecipeList().get();
    }
    try {
      final Response response = await dio.get(Settings.recipeListApiUrl);
      return RecipeList().getFromJson(json.decode(response.data));
    } catch (_) {
      return RecipeList().get();
    }
  }
}
