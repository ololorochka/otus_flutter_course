import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:otus_food/common.dart' as com;
import 'package:otus_food/settings.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/screens/recipe_screen.dart';
import 'package:otus_food/theme_data.dart';

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
              child: CachedNetworkImage(
                imageUrl: Settings.apiUrl + item.image,
                errorWidget: (context, url, error) => noPhoto(context),
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
                          com.getCookingTime(item.cookingTime),
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

  Widget noPhoto(BuildContext context) {
    return SizedBox(
      width: 149,
      height: 136,
      child: Icon(
        Icons.photo_camera,
        size: 90,
        color: Theme.of(context).colorScheme.neutralColor2,
      ),
    );
  }
}
