import 'package:intl/intl.dart';

class DateHelper {

  static String formatDateWithDay(String date) {
    return DateFormat('EEE, MMM-dd').format(
      DateFormat('dd-MMM-yyyy').parse(date),
    );
  }

  static String formatDateWithDayAndYear(String date) {
    return DateFormat('EEE, MMM-dd-yy').format(
      DateFormat('dd-MMM-yyyy').parse(date),
    );
  }

  static int getNoOfDaysInBetween(String fromDate, String toDate) {
    return DateFormat('dd-MMM-yyyy').parse(toDate).difference(DateFormat('dd-MMM-yyyy').parse(fromDate)).inDays;
  }

  static String getCurrentTime(){
    return DateTime.now().hour.toString() + DateTime.now().minute.toString() + DateTime.now().second.toString();
  }

  static String formatDateWithDayAndYearInNumbers(String date) {
    return DateFormat('ddMMyy').format(
      DateFormat('dd-MMM-yyyy').parse(date),
    );
  }
}
