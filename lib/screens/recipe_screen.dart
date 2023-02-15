import 'package:flutter/material.dart';
import 'package:otus_food/common.dart' as com;
import 'package:otus_food/models/recipe.dart';
import 'package:otus_food/theme_data.dart';
import 'package:otus_food/widgets/recipe/comments.dart';
import 'package:otus_food/widgets/recipe/favorite_button.dart';
import 'package:otus_food/widgets/recipe/step_checkbox.dart';
import 'package:otus_food/widgets/recipe/timer.dart';

// Виджет рецепта
class RecipeWidget extends StatefulWidget {
  const RecipeWidget(this.obj, {Key? key}) : super(key: key);
  final Recipe obj;

  @override
  State<RecipeWidget> createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  bool _isStartTimer = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: _isStartTimer ? Theme.of(context).colorScheme.secondary : null,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Рецепт'),
          centerTitle: true,
          actions: [Image.asset('assets/icons/icons8-meg-24.png')],
          bottom: _isStartTimer
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: TimerWidget(widget.obj.cookingTime),
                  ),
                )
              : null,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.obj.title,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        const SizedBox(width: 20),
                        FavoriteButton(widget.obj),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Image.asset('assets/icons/time.png'),
                        const SizedBox(width: 11),
                        Text(
                          com.getCookingTime(widget.obj.cookingTime),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        widget.obj.image,
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
                        children: widget.obj.ingredients
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
                                      padding: const EdgeInsets.symmetric(vertical: 6.0),
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
                    ...widget.obj.cooking
                        .map((step) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 7.0),
                              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: _isStartTimer
                                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.15)
                                    : Theme.of(context).colorScheme.neutralColor,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    step['num']!,
                                    style: TextStyle(
                                        fontSize: 40.0,
                                        color: _isStartTimer
                                            ? Theme.of(context).colorScheme.secondary
                                            : Theme.of(context).colorScheme.neutralColor3,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                                      child: Text(
                                        step['description']!,
                                        style: _isStartTimer
                                            ? Theme.of(context).textTheme.bodyText1
                                            : Theme.of(context).textTheme.headline6,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      StepCheckbox(isColored: _isStartTimer ? true : false),
                                      Text(
                                        step['time']!,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: _isStartTimer
                                              ? Theme.of(context).colorScheme.primary
                                              : Theme.of(context).colorScheme.neutralColor4,
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
                      child: _isStartTimer
                          ? OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _isStartTimer = false;
                                });
                              },
                              child: const Text('Закончить готовить'),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isStartTimer = true;
                                });
                              },
                              child: const Text('Начать готовить'),
                            ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: CommentWidget(widget.obj),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
