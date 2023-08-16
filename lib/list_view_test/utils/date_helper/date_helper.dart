import 'package:intl/intl.dart';

class DateHelper {
  static String formatDateWithDay(String date) {
    return DateFormat('EEE, MMM-dd').format(
      DateFormat('dd-MMM-yyyy').parse(date),
    );
  }

  static int getNoOfDaysInBetween(String fromDate, String toDate) {
    return DateFormat('dd-MMM-yyyy').parse(toDate).difference(DateFormat('dd-MMM-yyyy').parse(fromDate)).inDays;
  }
}
