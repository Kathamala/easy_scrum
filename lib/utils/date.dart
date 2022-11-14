import 'package:easy_scrum/utils/number.dart';

class Datetime {
  static String getDate(DateTime datetime) {
    return '${Number.formatNumber(datetime.day)}/${Number.formatNumber(datetime.month)}/${Number.formatNumber(datetime.year)}';
  }

  static String getTime(DateTime datetime) {
    return '${Number.formatNumber(datetime.hour)}:${Number.formatNumber(datetime.minute)}:${Number.formatNumber(datetime.second)}';
  }

  static String formatDatetime(DateTime datetime) {
    return '${getDate(datetime)} ${getTime(datetime)}';
  }
}
