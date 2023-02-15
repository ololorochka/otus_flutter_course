import 'package:flutter/material.dart';
import 'package:otus_food/theme_data.dart';

// Виджет чекбокса шагов приготовления
class StepCheckbox extends StatefulWidget {
  const StepCheckbox({this.isColored = false, super.key});
  final bool isColored;

  @override
  State<StepCheckbox> createState() => _StepCheckbox();
}

class _StepCheckbox extends State<StepCheckbox> {
  bool isChecked = false;

  Color getColor(Set<MaterialState> states) {
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.7,
      child: Checkbox(
        activeColor: Theme.of(context).colorScheme.primary,
        fillColor: widget.isColored ? MaterialStateProperty.resolveWith(getColor) : null,
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
