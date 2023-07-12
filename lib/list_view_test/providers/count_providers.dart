import 'package:flutter/widgets.dart';

class CountProviders extends ChangeNotifier {
  int _adultCount = 0;

  int get adultCount => _adultCount;

  void incrementAdultCount() {
    _adultCount++;
    notifyListeners();
  }

  void decrementAdultCount() {
    if (adultCount > 0) {
      _adultCount--;
      notifyListeners();
    }
  }

  int _childCount = 0;

  int get childCount => _childCount;

  void incrementChildCount() {
    _childCount++;
    notifyListeners();
  }

  void decrementChildCount() {
    if (childCount > 0) {
      _childCount--;
      notifyListeners();
    }
  }
}