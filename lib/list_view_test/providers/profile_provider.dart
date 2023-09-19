import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practise1/list_view_test/models/user_profile/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  String? _name;
  String? _reservedFor;
  String? _mobileNo;
  String? _emailId;
  String? _dateOfBirth;
  String _gender = "Undisclosed";
  String _maritalStatus = "Undisclosed";
  final DateTime _dateTimeObject = DateTime.now();
  final DateFormat _dateFormat = DateFormat("dd-MMM-yyyy");
  bool _isLoading = false;
  String? _uid;

  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();

  String? get name => _name;

//todo this needs to be checked
  String? get reservedFor => _reservedFor ?? _name;

  Future<void> setName(String value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _name = value;
    _reservedFor = value;
    sharedPreferences.setString("name", _name!);
    notifyListeners();
  }

  void setReservedFor(String value) {
    _reservedFor = value;
  }

  void setProfileDataFromModel(UserProfileModel userProfileModel) {
    _name = userProfileModel.name;
    _emailId = userProfileModel.emailId;
    _mobileNo = userProfileModel.mobileNo;
    _dateOfBirth = userProfileModel.dateOfBirth;
    _gender = userProfileModel.gender;
    _maritalStatus = userProfileModel.maritalStatus;
    _uid = userProfileModel.uid;
    setSharedPreferences();
    notifyListeners();
  }

  Future<void> setSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("name", _name!);
    print(sharedPreferences.getString("name"));
    sharedPreferences.setString("emailId", _emailId!);
    sharedPreferences.setString("mobileNo", _mobileNo!);
    sharedPreferences.setString("dateOfBirth", _dateOfBirth!);
    sharedPreferences.setString("gender", _gender);
    sharedPreferences.setString("maritalStatus", _maritalStatus);
    sharedPreferences.setString("uid", _uid!);
    print(sharedPreferences.getString("gender"));
    notifyListeners();
  }

  Future<void> setProfileDataFromSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    _name = sharedPreferences.getString("name");
    _emailId = sharedPreferences.getString("emailId");
    _mobileNo = sharedPreferences.getString("mobileNo");
    _dateOfBirth = sharedPreferences.getString("dateOfBirth");
    _gender = sharedPreferences.getString("gender")!;
    _maritalStatus = sharedPreferences.getString("maritalStatus")!;
    _uid = sharedPreferences.getString("uid");
    notifyListeners();
  }

  void clearProfileProviderData() {
    _name = '';
    _emailId = '';
    _mobileNo = '';
    _dateOfBirth = '';
    _gender = "Undisclosed";
    _maritalStatus = "Undisclosed";
    _uid = '';
    notifyListeners();
  }

  String get mobileNo => _mobileNo!;

  set mobileNo(String value) {
    _mobileNo = value;
    notifyListeners();
  }

  String? get emailId => _emailId;

  setEmailId(String value) {
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
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUid(String uid) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString("uid", uid);
    _uid = sharedPreferences.getString("uid");
  }

  void setSignIn(bool value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool("isSignedIn", value);
  }

  String get uid => _uid!;

  void setMobileNo(String value) {
    _mobileNo = value;
  }
}
