import 'package:flutter/material.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/widgets/recipe.dart';

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

// Виджет элемента списка рецептов
class RecipeItemWidget extends StatelessWidget {
  const RecipeItemWidget(this.item, {Key? key}) : super(key: key);

  final Recipe item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => RecipeWidget(item),
          ),
        );
      },
    );
  }
}
