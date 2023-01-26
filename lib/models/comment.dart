import 'package:otus_food/common.dart';
import 'package:otus_food/models/recipe.dart';

// Комментарий
class Comment {
  int? commentId;
  int recipeId;
  String? date;
  String text;
  int? userId;
  String userName;
  String? userPic;

  static const String _defaultName = 'Гость';

  Comment({required this.recipeId, required this.text, this.userId, this.userName = _defaultName});

  Comment.fromMap(Map<String, dynamic> map)
      : commentId = map['comment_id'],
        recipeId = map['recipe_id'],
        date = map['date'],
        text = map['text'],
        userId = map['user_id'],
        userName = map['user_name'],
        userPic = map['user_pic'];

  // Пока нам некуда сохранять
  void save() {
    date ??= getDateNow();
  }
}

// Список комментов
class CommentList {
  final List<Comment> _items = [];
  Recipe recipe;
  CommentList(this.recipe);

  // Пока так
  void add(Comment comment) {
    recipe.comments.add(comment); // Временно. Пока нет ни БД, ни провайдера, сохраняем в этой структуре
  }
}
