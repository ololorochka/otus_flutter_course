import 'package:flutter/material.dart';
import 'package:otus_food/theme_data.dart';
import 'package:otus_food/models/recipe.dart';

// Виджет избранного
class FavoriteButton extends StatefulWidget {
  const FavoriteButton(this.obj, {super.key});
  final Recipe obj;

  @override
  State<FavoriteButton> createState() => _FavoriteWidget();
}

class _FavoriteWidget extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(top: 5.0),
      alignment: Alignment.topCenter,
      onPressed: () {
        setState(() {
          widget.obj.setFavorite(!widget.obj.favorite);
        });
      },
      icon: Icon(
        Icons.favorite,
        color: widget.obj.favorite
            ? Theme.of(context).colorScheme.favoriteColor
            : Theme.of(context).colorScheme.neutralColor5,
      ),
    );
  }
}
