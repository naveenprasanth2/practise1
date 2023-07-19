import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateProvider extends ChangeNotifier {
  String? date;
  String? initialDate;
  int noOfDays = 1;

  DateProvider() {
    seInitialDate();
  }


  void setDate(BuildContext context) async {
    await showDateRangePicker(
      context: context,
      currentDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor: Colors.red.shade400, // Set the primary color to red
            hintColor: Colors.red.shade400, // Set the accent color to red
            colorScheme: ColorScheme.light(
              primary: Colors.red.shade400, // Set the primary color to red
            ),
          ),
          child: child ?? Container(),
        );
      },
    ).then((value) {
      if (value != null) {
        DateFormat format = DateFormat("MMM-dd");
        date = "${format.format(value.start)} - ${format.format(value.end)}";
        noOfDays = value.end.difference(value.start).inDays;
      } else {
        date = date ?? initialDate;
      }
      notifyListeners();
    });
  }

  void seInitialDate() {
    DateFormat format = DateFormat("MMM-dd");
    initialDate =
        "${format.format(DateTime.now().add(const Duration(days: 1)))} - ${format.format(DateTime.now().add(const Duration(days: 2)))}";
    notifyListeners();
  }
}
