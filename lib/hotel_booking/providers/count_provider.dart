import 'package:flutter/widgets.dart';
import 'package:practise1/hotel_booking/models/room_occupancy/room_model.dart';

class CountProvider extends ChangeNotifier {
  int _adultCount = 1;
  int _tempAdultCount = 1;
  List<RoomModel> roomsInfo = [RoomModel()];
  int _maxAdultCountByCustomer = 1;

  void setRoomsDetails(List<RoomModel> roomsInfo) {
    this.roomsInfo = roomsInfo;
  }

  void setMaximumAdultCount(int adultCount) {
    _adultCount = adultCount;
    setMaximumAdultAllowed();
    notifyListeners();
  }

  void setAdultAndChildCount(List<RoomModel> roomsInfo) {
    _adultCount = roomsInfo
        .map((roomGuests) => roomGuests.adults)
        .fold(0, (previousValue, element) => previousValue + element);
    _maxAdultCountByCustomer = roomsInfo
        .map((roomGuests) => roomGuests.adults)
        .reduce((maxValue, element) => maxValue > element ? maxValue : element);
    _childCount = roomsInfo
        .map((roomGuests) => roomGuests.children)
        .fold(0, (previousValue, element) => previousValue + element);
    notifyListeners();
  }

  void setMaximumAdultAllowed() {
    for (var roomData in roomsInfo) {
      roomData.adults =
          roomData.adults > adultCount ? adultCount : roomData.adults;
    }
  }

  int get adultCount => _adultCount;

  int get tempAdultCount => _tempAdultCount;

  int get maxAdultCountByCustomer => _maxAdultCountByCustomer;

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

  void notifyAdultListeners() {
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

  void notifyChildListeners() {
    _childCount = _tempChildCount;
    notifyListeners();
  }
}
