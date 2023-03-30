import 'package:flutter/material.dart';

// Виджет чекбокса шагов приготовления
class StepCheckbox extends StatefulWidget {
  const StepCheckbox({this.isColored = false, super.key});
  final bool isColored;

  @override
  State<StepCheckbox> createState() => _StepCheckbox();
}

class _StepCheckbox extends State<StepCheckbox> with SingleTickerProviderStateMixin {
  bool isChecked = false;
  late AnimationController animationController;
  final range = Tween<double>(begin: 1.7, end: 2.5);

  Color getColor(Set<MaterialState> states) {
    return Theme.of(context).colorScheme.primary;
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        child: Checkbox(
          activeColor: Theme.of(context).colorScheme.primary,
          fillColor: widget.isColored ? MaterialStateProperty.resolveWith(getColor) : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          value: isChecked,
          onChanged: (bool? value) {
            animationController.forward();
            setState(() {
              isChecked = value!;
            });
          },
        ),
        builder: (BuildContext context, Widget? child) {
          return Transform.scale(
            scale: range.evaluate(animationController),
            child: child,
          );
        });
  }
}
