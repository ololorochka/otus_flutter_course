import 'package:flutter/material.dart';
import 'package:otus_food/models/recipe.dart';
import 'package:rive/rive.dart';

// Виджет избранного
class FavoriteButton extends StatefulWidget {
  const FavoriteButton(this.obj, {super.key});
  final Recipe obj;

  @override
  State<FavoriteButton> createState() => _FavoriteWidget();
}

class _FavoriteWidget extends State<FavoriteButton> {
  StateMachineController? _smController;
  SMIInput<bool>? _boolExampleInput;
  final String _stateMachine = 'State Machine 1';

  // Инициализация внешней анимации
  void _onRiveInit(Artboard artboard, bool favorite) {
    _smController = StateMachineController.fromArtboard(artboard, _stateMachine);
    artboard.addController(_smController!);

    _boolExampleInput = _smController!.findInput<bool>('Like') as SMIBool;
    _boolExampleInput!.value = favorite;
  }

  // Переключение состояния избранного
  void _toggle() {
    setState(() {
      widget.obj.setFavorite(!widget.obj.favorite);
      _boolExampleInput!.value = widget.obj.favorite;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: SizedBox(
        width: 50,
        height: 50,
        child: RiveAnimation.asset(
          'assets/icons/heart.riv',
          fit: BoxFit.cover,
          stateMachines: [_stateMachine],
          onInit: (art) {
            _onRiveInit(art, widget.obj.favorite);
          },
        ),
      ),
    );
  }
}
