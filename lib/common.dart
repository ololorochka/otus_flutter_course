import 'package:intl/intl.dart' as intl;

// получить дату в формате:
String getDateNow() {
  return intl.DateFormat('dd.MM.yyyy').format(DateTime.now());
}
