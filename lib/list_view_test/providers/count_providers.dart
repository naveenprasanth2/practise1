import 'package:flutter/widgets.dart';

class CountProviders extends ChangeNotifier {
  int _adultCount = 2;
  int _tempAdultCount = 2;

  int get adultCount => _adultCount;
  int get tempAdultCount => _tempAdultCount;

  void incrementAdultCount() {
    _tempAdultCount++;
    notifyListeners();
  }

  void decrementAdultCount() {
    if (_tempAdultCount > 1) {
      _tempAdultCount--;
      notifyListeners();
    }
  }


  void notifyAdultListeners(){
    _adultCount = _tempAdultCount;
    notifyListeners();
  }


  int _childCount = 0;
  int _tempChildCount = 0;

  int get childCount => _childCount;
  int get tempChildCount => _tempChildCount;

  void incrementChildCount() {
    _tempChildCount++;
    notifyListeners();
  }

  void decrementChildCount() {
    if (_tempChildCount > 0) {
      _tempChildCount--;
      notifyListeners();
    }
  }

  void notifyChildListeners(){
    _childCount = _tempChildCount;
    notifyListeners();
  }
}