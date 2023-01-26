import 'package:flutter/material.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/theme_data.dart';
import 'package:otus_food/widgets/comments.dart';

// Виджет рецепта
class RecipeWidget extends StatelessWidget {
  const RecipeWidget(this.obj, {Key? key}) : super(key: key);
  final Recipe obj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Рецепт'),
        centerTitle: true,
        actions: [Image.asset('assets/icons/icons8-meg-24.png')],
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          obj.title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      const SizedBox(width: 20),
                      FavoriteWidget(obj),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset('assets/icons/time.png'),
                      const SizedBox(width: 11),
                      Text(
                        obj.cookingTime,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      obj.image,
                      // width: 149,
                      // height: 136,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Ингредиенты',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.neutralColor4, width: 3.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: obj.ingredients
                          .map((ingredient) => Row(
                                children: [
                                  const Icon(Icons.circle, size: 5),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                                      child: Text(
                                        ingredient['name']!,
                                        style: Theme.of(context).textTheme.headline5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                                    child: Text(
                                      ingredient['quantity']!,
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Шаги приготовления',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 15),
                  ...obj.cooking
                      .map((step) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 7.0),
                            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.neutralColor),
                              borderRadius: BorderRadius.circular(6),
                              color: Theme.of(context).colorScheme.neutralColor,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  step['num']!,
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      color: Theme.of(context).colorScheme.neutralColor3,
                                      fontWeight: FontWeight.w900),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                                    child: Text(
                                      step['description']!,
                                      style: Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    const StepCheckbox(),
                                    Text(
                                      step['time']!,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Theme.of(context).colorScheme.neutralColor4,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  const SizedBox(height: 20),
                  Align(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Начать готовить'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  CommentWidget(obj),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Виджет чекбокса шагов приготовления
class StepCheckbox extends StatefulWidget {
  const StepCheckbox({super.key});

  @override
  State<StepCheckbox> createState() => _StepCheckbox();
}

class _StepCheckbox extends State<StepCheckbox> {
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).colorScheme.neutralColor4;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.7,
      child: Checkbox(
        activeColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}

// Виджет избранного
class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget(this.obj, {super.key});
  final Recipe obj;

  @override
  State<FavoriteWidget> createState() => _FavoriteWidget();
}

class _FavoriteWidget extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
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
