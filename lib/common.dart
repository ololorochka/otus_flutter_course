import 'package:intl/intl.dart' as intl;

// получить дату в формате день-месяц-год
String getDateNow() {
  return intl.DateFormat('dd.MM.yyyy').format(DateTime.now());
}

// получить человекочитаемое время пригоовления
String getCookingTime(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = seconds % 3600 ~/ 60;
  String hoursStr = hours > 0 ? '$hours ч ' : '';
  String minutesStr = minutes > 0 ? '$minutes мин' : '';

  return '$hoursStr$minutesStr';
}

// получить время в формате HH:MM:SS
String getTimerTime(int seconds) {
  int hours = seconds ~/ 3600;
  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = (seconds % 3600 ~/ 60).toString().padLeft(2, '0');
  String secondsStr = (seconds % 3660 % 60).toString().padLeft(2, '0');

  return hours > 0 ? "$hoursStr:$minutesStr:$secondsStr" : "$minutesStr:$secondsStr";
}
