import 'package:flutter/material.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/widgets/recipe/recipe_item.dart';

// Виджет списка рецептов
class RecipeListWidget extends StatelessWidget {
  const RecipeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Recipe> recipes = RecipeList().items; // Временное решение
    return recipes.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: RecipeItemWidget(recipes[index]),
              );
            },
          )
        : Text(
            'Нет данных',
            style: Theme.of(context).textTheme.headline2,
          );
  }
}
