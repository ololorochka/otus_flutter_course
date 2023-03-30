import 'dart:io';

class Settings {
  static const String apiUrl = 'https://bars.org.ru/static/';
  static const String recipeListApiUrl = 'https://bars.org.ru/static/recipe_list';
  static const String recipeBox = 'recipes';
  static const String imageDirName = 'images';
  Directory? appDir;

  Settings._();
  static final Settings _singleton = Settings._();
  factory Settings() => _singleton;

  // Директория для фото пользователя
  String? get imageDir => appDir != null ? '${appDir!.path}/${Settings.imageDirName}' : null;
}
