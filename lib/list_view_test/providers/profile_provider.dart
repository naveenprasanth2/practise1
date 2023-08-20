import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileProvider extends ChangeNotifier {
  String? _name;
  String? _mobileNo;
  String? _emailId;
  String? _dateOfBirth;
  String _gender = "Undisclosed";
  String _maritalStatus = "Undisclosed";
  final DateTime _dateTimeObject = DateTime.now();
  final DateFormat _dateFormat = DateFormat("dd-MMM-yyyy");

  String get name => _name!;

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  String get mobileNo => _mobileNo!;

  set mobileNo(String value) {
    _mobileNo = value;
    notifyListeners();
  }

  String get emailId => _emailId!;

  set emailId(String value) {
    _emailId = value;
    notifyListeners();
  }

  String? get dateOfBirth => _dateOfBirth;

  void setDateOfBirth(BuildContext context) async {
    await showDatePicker(
      context: context,
      firstDate: DateTime(_dateTimeObject.year - 100),
      lastDate: DateTime(_dateTimeObject.year - 18, _dateTimeObject.month,
          _dateTimeObject.day),
      initialDate: DateTime(_dateTimeObject.year - 18, _dateTimeObject.month,
          _dateTimeObject.day),
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
        _dateOfBirth = _dateFormat.format(value);
      }
      notifyListeners();
    });
  }

  String get gender => _gender;

  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  String get maritalStatus => _maritalStatus;

  void setMaritalStatus(String value) {
    _maritalStatus = value;
  }
}
