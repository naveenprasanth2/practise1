import 'package:flutter/cupertino.dart';

import '../models/booking_history_model/booking_history_display_model.dart';

class BookingDataProvider extends ChangeNotifier {
  List<BookingHistoryDisplayModel> _upcomingList = [];
  List<BookingHistoryDisplayModel> _checkedOutList = [];
  List<BookingHistoryDisplayModel> _cancelledList = [];

  List<BookingHistoryDisplayModel> get upcomingList => _upcomingList;

  List<BookingHistoryDisplayModel> get checkedOutList => _checkedOutList;

  List<BookingHistoryDisplayModel> get cancelledList => _cancelledList;

  void setUpcomingList(List<BookingHistoryDisplayModel> upcomingList) {
    _upcomingList = upcomingList;
    notifyListeners();
  }

  void setCheckedOutList(List<BookingHistoryDisplayModel> checkedOutList) {
    _checkedOutList = checkedOutList;
    notifyListeners();
  }

  void setCancelledList(List<BookingHistoryDisplayModel> cancelledList) {
    _cancelledList = cancelledList;
    notifyListeners();
  }

  void swapDataFromUpcomingToCancelledList(String bookingId){
    BookingHistoryDisplayModel removedValue = _upcomingList.firstWhere((element) => element.bookingHistoryModel.checkOutStatus == "cancelled");
    _upcomingList.removeWhere((element) => element.bookingHistoryModel.checkOutStatus == "cancelled");
    _cancelledList.insert(0, removedValue);
    notifyListeners();
  }
}
