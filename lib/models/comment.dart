import 'dart:io';
import 'package:hive/hive.dart';
import 'package:otus_food/settings.dart';
import 'package:otus_food/common.dart' as com;
import 'package:otus_food/models/recipe.dart';

// Комментарий
@HiveType(typeId: 129)
class Comment {
  @HiveField(0)
  int? commentId;

  @HiveField(1)
  int recipeId;

  @HiveField(2)
  String? date;

  @HiveField(3)
  String text;

  @HiveField(4)
  int? userId;

  @HiveField(5)
  String? userName;

  @HiveField(6)
  String? userPic;

  @HiveField(7)
  String? photo;

  @HiveField(8)
  bool isLocal = false;

  static const String _defaultName = 'Гость';

  Comment(
      {this.commentId,
      required this.recipeId,
      this.date,
      required this.text,
      this.userId,
      this.userName = _defaultName,
      this.userPic,
      this.photo,
      this.isLocal = false});

  Comment.fromMap(Map<String, dynamic> map)
      : commentId = map['comment_id'],
        recipeId = map['recipe_id'],
        date = map['date'],
        text = map['text'],
        userId = map['user_id'],
        userName = map['user_name'],
        userPic = map['user_pic'],
        photo = map['photo'],
        isLocal = map['isLocal'] ?? false;

  // т.к. у нас нет редактирования комментов, считаем, что коммент всегда новый
  void save() {
    date ??= com.getDateNow();

    // Если коммент локальный (не из сети), сохраним фото в пользовательской директории
    if (isLocal && photo != null) {
      final File tmpFile = File(photo!);
      final String newFilePath = '${Settings().imageDir}/${tmpFile.path.split('/').last}';
      tmpFile.copy(newFilePath);
      tmpFile.delete();
      photo = newFilePath;
    }
  }
}

// Список комментов
class CommentList {
  Recipe recipe;
  CommentList(this.recipe);

  void add(Comment comment) {
    recipe.comments.add(comment);
    recipe.save();
  }
}
