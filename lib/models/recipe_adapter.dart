import 'package:hive/hive.dart';
import 'package:otus_food/models/recipe.dart';

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  int get typeId => 128;

  @override
  Recipe read(BinaryReader reader) {
    return Recipe(
      recipeId: reader.readInt(),
      title: reader.readString(),
      cookingTime: reader.readInt(),
      image: reader.readString(),
      ingredients: reader.readList(),
      cooking: reader.readList(),
      comments: reader.readList(),
      favorite: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer.writeInt(obj.recipeId);
    writer.writeString(obj.title);
    writer.writeInt(obj.cookingTime);
    writer.writeString(obj.image);
    writer.writeList(obj.ingredients);
    writer.writeList(obj.cooking);
    writer.writeList(obj.comments);
    writer.writeBool(obj.favorite);
  }
}
