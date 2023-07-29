import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateProvider extends ChangeNotifier {
  String? date;
  String? initialDate;
  int noOfDays = 1;
  String? _checkInDate;
  String? _checkOutDate;

  DateProvider() {
    seInitialDate();
  }

  String get checkInDate => _checkInDate!;

  String get checkOutDate => _checkOutDate!;

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
      DateFormat format = DateFormat("MMM-dd");
      if (value != null) {
        date = "${format.format(value.start)} - ${format.format(value.end)}";
        noOfDays = value.end.difference(value.start).inDays;
      } else {
        date = date ?? initialDate;
      }
      _checkInDate = format.format(value!.start);
      _checkOutDate = format.format(value.end);
      notifyListeners();
    });
  }

  void seInitialDate() {
    DateFormat format = DateFormat("MMM-dd");
    initialDate =
        "${format.format(DateTime.now().add(const Duration(days: 1)))} - ${format.format(DateTime.now().add(const Duration(days: 2)))}";
    _checkInDate = format.format(DateTime.now().add(const Duration(days: 1)));
    _checkOutDate = format.format(DateTime.now().add(const Duration(days: 2)));
    notifyListeners();
  }
}
