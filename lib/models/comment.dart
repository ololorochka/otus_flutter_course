import 'package:hive/hive.dart';
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

  static const String _defaultName = 'Гость';

  Comment({
    this.commentId,
    required this.recipeId,
    this.date,
    required this.text,
    this.userId,
    this.userName = _defaultName,
    this.userPic,
  });

  Comment.fromMap(Map<String, dynamic> map)
      : commentId = map['comment_id'],
        recipeId = map['recipe_id'],
        date = map['date'],
        text = map['text'],
        userId = map['user_id'],
        userName = map['user_name'],
        userPic = map['user_pic'];

  void save() {
    date ??= com.getDateNow();
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
