import 'package:flutter/material.dart';
import 'package:otus_food/models/recipe.dart';

// Виджет списка рецептов
class RecipeListWidget extends StatelessWidget {
  const RecipeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Recipe> recipes = RecipeList().items; // пока так
    return recipes.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              return recipe(context, recipes[index]);
            })
        : Text(
            'Нет данных',
            style: Theme.of(context).textTheme.headline2,
          );
  }

  // Виджет элемента списка рецептов
  Widget recipe(BuildContext context, Recipe item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      shadowColor: const Color(0x60000000),
      elevation: 7,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4.0),
              bottomLeft: Radius.circular(4.0),
            ),
            child: Image.asset(
              item.image,
              width: 149,
              height: 136,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/time.png',
                      ),
                      const SizedBox(width: 11),
                      Text(
                        item.cookingTime,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
