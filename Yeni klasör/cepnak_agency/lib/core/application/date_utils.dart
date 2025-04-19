import 'package:intl/intl.dart';

String dateFormatWithHours(DateTime? date){
  return DateFormat('HH:mm - dd/MM/yyyy').format(date ?? DateTime.now());
}
String dateFormat(DateTime? date){
  return DateFormat('dd/MM/yyyy').format(date ?? DateTime.now());
}