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
    return DateFormat('dd-MMM-yyyy')
        .parse(toDate)
        .difference(DateFormat('dd-MMM-yyyy').parse(fromDate))
        .inDays;
  }

  static String getCurrentTime() {
    return DateTime.now().hour.toString() +
        DateTime.now().minute.toString() +
        DateTime.now().second.toString();
  }

  static String getCurrentDate() {
    return DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  }

  static String formatDateWithDayAndYearInNumbers(String date) {
    return DateFormat('ddMMyy').format(
      DateFormat('dd-MMM-yyyy').parse(date),
    );
  }

  static bool canCancelBooking(String checkInDate, String checkInTime) {
    // Parse the check-in date string into a DateTime object
    DateFormat dateFormatter = DateFormat("dd-MMM-yyyy");
    DateTime checkInDateObj = dateFormatter.parse(checkInDate);

    // Parse the check-in time string into a DateTime object
    DateFormat timeFormatter = DateFormat("hh:mma");
    DateTime checkInTimeObj = timeFormatter.parse(checkInTime);

    // Combine the check-in date and time to create a DateTime object
    DateTime checkInDateTime = DateTime(
      checkInDateObj.year,
      checkInDateObj.month,
      checkInDateObj.day,
      checkInTimeObj.hour,
      checkInTimeObj.minute,
    );

    // Calculate the target check-in date and time after 26 hours
    DateTime targetDateTime = DateTime.now().add(const Duration(hours: 27));

    // If the check-in time is after the target time, the user can cancel
    return checkInDateTime.isAfter(targetDateTime);
  }
}
