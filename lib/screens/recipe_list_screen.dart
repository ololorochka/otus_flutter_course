import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/controllers/recipe_list_controller.dart';
import 'package:otus_food/widgets/recipe/recipe_item.dart';

// Виджет списка рецептов
class RecipeListWidget extends StatefulWidget {
  const RecipeListWidget({Key? key}) : super(key: key);

  @override
  State<RecipeListWidget> createState() => _RecipeListWidgetState();
}

class _RecipeListWidgetState extends State<RecipeListWidget> {
  Future<List<Recipe>>? recipes;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    recipes = RecipeListController.loadRecipeList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recipe>>(
      future: recipes,
      builder: (context, snapshot) {
        return recipes == null
            ? Text(
                'Нет данных',
                style: Theme.of(context).textTheme.headline2,
              )
            : snapshot.hasData
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                    itemCount: snapshot.requireData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: RecipeItemWidget(snapshot.requireData[index]),
                      );
                    },
                  )
                : snapshot.hasError
                    ? Text(
                        'Нет данных',
                        style: Theme.of(context).textTheme.headline2,
                      )
                    : const CircularProgressIndicator();
      },
    );
  }
}
