import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateProvider extends ChangeNotifier {
  String? date;

  void setDate(BuildContext context) async {
    await showDateRangePicker(
            context: context,
            currentDate: DateTime.now().add(const Duration(days: 1)),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 90)))
        .then((value) {
      DateFormat format = DateFormat("MMM-dd");
      date = "${format.format(value!.start)} - ${format.format(value.end)}";
      notifyListeners();
    });
  }
}
