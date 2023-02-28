import 'package:otus_food/models/comment.dart';
import 'package:hive/hive.dart';

// Рецепт
@HiveType(typeId: 128)
class Recipe extends HiveObject {
  @HiveField(0)
  int recipeId;

  @HiveField(2)
  String title;

  @HiveField(3)
  int cookingTime;

  @HiveField(4)
  String image;

  @HiveField(5)
  List ingredients;

  @HiveField(6)
  List cooking;

  @HiveField(7)
  List comments = [];

  @HiveField(8)
  bool favorite = false;

  Recipe({
    required this.recipeId,
    required this.title,
    required this.cookingTime,
    required this.image,
    required this.ingredients,
    required this.cooking,
    comments,
    this.favorite = false,
  }) : comments = comments ?? [];

  Recipe.fromMap(Map<String, dynamic> map)
      : recipeId = map['recipe_id'],
        title = map['title'],
        cookingTime = map['cooking_time'],
        image = map['image'],
        ingredients = map['ingredients'],
        cooking = map['cooking'],
        comments = map['comments'] != null ? map['comments'].map((e) => Comment.fromMap(e)).toList() : [],
        favorite = map['favorite'] ?? false;

  void setFavorite(bool isFavorite) {
    favorite = isFavorite;
    super.save();
  }
}
