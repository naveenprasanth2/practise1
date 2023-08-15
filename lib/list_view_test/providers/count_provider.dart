import 'package:flutter/widgets.dart';
import 'package:practise1/list_view_test/models/room_occupancy/room_model.dart';

class CountProvider extends ChangeNotifier {
  int _adultCount = 2;
  int _tempAdultCount = 1;
  List<RoomModel> roomsInfo = [RoomModel()];

  void setRoomsDetails(List<RoomModel> roomsInfo){
    this.roomsInfo = roomsInfo;
  }

  void setMaximumAdultCount(int adultCount){
    _adultCount = adultCount;
    setMaximumAdultAllowed();
    notifyListeners();
  }

  void setMaximumAdultAllowed(){
    for (var roomData in roomsInfo) {
      roomData.adults = roomData.adults > adultCount ? adultCount : roomData.adults;
    }
  }

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