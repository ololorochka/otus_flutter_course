import 'dart:async';
import 'package:flutter/material.dart';
import 'package:otus_food/common.dart' as com;
import 'package:otus_food/theme_data.dart';

// Виджет таймера
class TimerWidget extends StatefulWidget {
  TimerWidget(this.timerTime, {super.key});
  int timerTime;

  @override
  State<TimerWidget> createState() => _TimerWidget();
}

class _TimerWidget extends State<TimerWidget> {
  Timer? _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (widget.timerTime == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            widget.timerTime--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Spacer(),
        Text(
          'Таймер',
          style: TextStyle(
            fontSize: 15.0,
            color: Theme.of(context).colorScheme.canvasColor,
          ),
        ),
        const Spacer(),
        Text(
          com.getTimerTime(widget.timerTime),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.canvasColor,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
