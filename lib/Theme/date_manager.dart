// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

class DateManager {
  getDate(String date) {
    DateFormat format = DateFormat("yyyy-mm-dd");
    DateTime dateTime = format.parse(date, true);
    String formattedDate = DateFormat('dd-mm-yyyy').format(dateTime);
    return formattedDate;
  }

  getDayAndMonth(String date) {
    DateFormat format = DateFormat("yyyy-mm-dd");
    DateTime dateTime = format.parse(date, true);
    String formattedDate = DateFormat('dd-mm').format(dateTime);
    return formattedDate;
  }

  getDateTime(String date) {
    DateFormat format = DateFormat("yyyy-mm-dd HH:mm");
    DateTime dateTime = format.parse(date, true);
    String formattedDate = DateFormat('dd-mm-yyyy / HH:mm a').format(dateTime);
    return formattedDate;
  }

  getDateTimeWithSecond(String date) {
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime dateTime = format.parse(date, true);
    String formattedDate = DateFormat('dd-MM-yyyy / HH:mm a').format(dateTime);
    return formattedDate;
  }
}
