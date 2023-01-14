// Рецепт
class Recipe {
  int recipeId;
  String title;
  String cookingTime;
  String image;
  Recipe({required this.recipeId, required this.title, required this.cookingTime, required this.image});

  Recipe.fromMap(Map<String, dynamic> map)
      : recipeId = map['recipeId'],
        title = map['title'],
        cookingTime = map['cookingTime'],
        image = map['image'];
}

// Список рецептов
class RecipeList {
  RecipeList._();
  static final RecipeList _singleton = RecipeList._();
  factory RecipeList() => _singleton;

  List<Recipe>? _items;
  List<Map<String, dynamic>> getData() => textRecipeData; // Как бы получаем из внешнего источника

  List<Recipe> get items => _items ??= getData().map((e) => Recipe.fromMap(e)).toList();
}

// Тестовые данные, которые мы можем получать из разных источников
List<Map<String, dynamic>> textRecipeData = [
  {
    'recipeId': 111,
    'title': 'Медовые крылышки в духовке',
    'cookingTime': '1 ч 50 мин',
    'image': 'assets/images/111.jpg',
  },
  {
    'recipeId': 112,
    'title': 'Курица с чесноком на сковороде жареная',
    'cookingTime': '40 мин',
    'image': 'assets/images/112.jpg',
  },
  {
    'recipeId': 113,
    'title': 'Котлеты из фарша в духовке с подливкой',
    'cookingTime': '1 ч',
    'image': 'assets/images/113.jpg',
  },
  {
    'recipeId': 114,
    'title': 'Грибы шампиньоны на гриле',
    'cookingTime': '2 ч',
    'image': 'assets/images/114.jpg',
  },
  {
    'recipeId': 115,
    'title': 'Овощи запеченные в рукаве в духовке',
    'cookingTime': '45 мин',
    'image': 'assets/images/115.jpg',
  },
  {
    'recipeId': 116,
    'title': 'Киш с семгой и брокколи',
    'cookingTime': '2 ч',
    'image': 'assets/images/116.jpg',
  },
  {
    'recipeId': 117,
    'title': 'Фаршированные перцы с рисом и овощами в духовке',
    'cookingTime': '1 ч',
    'image': 'assets/images/117.jpg',
  },
  {
    'recipeId': 118,
    'title': 'Карп фаршированный запеченный в духовке целиком',
    'cookingTime': '1 ч 30 мин',
    'image': 'assets/images/118.jpg',
  },
  {
    'recipeId': 119,
    'title': 'Салат цезарь классический с курицей',
    'cookingTime': '30 мин',
    'image': 'assets/images/119.jpg',
  },
  {
    'recipeId': 120,
    'title': 'Борщ с пекинской капустой',
    'cookingTime': '40 мин',
    'image': 'assets/images/120.jpg',
  },
];
