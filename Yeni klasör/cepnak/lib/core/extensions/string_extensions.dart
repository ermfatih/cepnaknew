import 'package:intl/intl.dart';

extension ColorStringExtension on String?{
  int get colorValue{
    var _newColor=this?.replaceFirst('#', '0xff') ?? '';
    return int.parse(_newColor);
  }
}

String dateFormatWithHours(DateTime? date){
  return DateFormat('HH:mm - dd/MM/yyyy').format(date ?? DateTime.now());
}
String dateFormat(DateTime? date){
  return DateFormat('dd/MM/yyyy').format(date ?? DateTime.now());
}