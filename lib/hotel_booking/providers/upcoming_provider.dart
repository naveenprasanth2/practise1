import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practise1/hotel_booking/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/hotel_booking/models/booking_history_model/booking_history_model.dart';
import 'package:practise1/hotel_booking/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/hotel_booking/models/hotel_search/hotel_search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingProvider extends ChangeNotifier {
  BookingHistoryDisplayModel? _bookingHistoryDisplayModel;
  BookingHistoryModel? _bookingHistoryModel;
  HotelSearchModel? _hotelSearchModel;
  HotelDetailsModel? _hotelDetailsModel;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  BookingHistoryDisplayModel? get bookingHistoryDisplayModel =>
      _bookingHistoryDisplayModel;

  HotelDetailsModel get hotelDetailsModel => _hotelDetailsModel!;

  UpcomingProvider() {
    init();
  }

  Future<void> init() async {
    await getBookingsDetails();
  }

  Future<void> getBookingsDetails() async {
    List<BookingHistoryModel> myBookingHistoryList = [];
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String userId = sharedPreferences.getString("mobileNo")!;
    final bookingsCollection = _firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("bookings");

    // Fetch all the documents from the bookings collection
    final QuerySnapshot bookingsSnapshot = await bookingsCollection.get();
    List<dynamic> allValues = [];

    for (var doc in bookingsSnapshot.docs) {
      Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;
      allValues.addAll(dataMap.values);
    }

    myBookingHistoryList.addAll(allValues
        .map((value) => BookingHistoryModel.fromJson(value))
        .where((element) =>
            element.paymentStatus == "verified" ||
            element.paymentStatus == "success" ||
            element.paymentStatus == "processing refund" ||
            element.paymentStatus == "refund processed")
        .toList());
    // Sort the list based on the checkIndate field
    myBookingHistoryList.removeWhere((element) => (DateFormat("dd-MMM-yyyy")
            .parse(element.checkInDate)
            .isAfter(DateTime.now()) &&
        DateTime.now().hour < 12));
    myBookingHistoryList.sort((a, b) {
      DateTime dateA = DateFormat("dd-MMM-yyyy").parse(a.checkInDate);
      DateTime dateB = DateFormat("dd-MMM-yyyy").parse(b.checkInDate);
      return dateA.compareTo(dateB); // For descending order
    });
    if (myBookingHistoryList.isNotEmpty) {
      _bookingHistoryModel = myBookingHistoryList.first;
    }
    await getHotelSearchDetail(_bookingHistoryModel!);
    await setHotelDetails(_bookingHistoryModel!);
    notifyListeners();
  }

  Future<void> getHotelSearchDetail(
      BookingHistoryModel bookingHistoryModel) async {
    final querySnapshot = await _firebaseFirestore
        .collection(
            bookingHistoryModel.cityAndState.split(",")[1].trim().toLowerCase())
        .doc(
            bookingHistoryModel.cityAndState.split(",")[0].trim().toLowerCase())
        .collection("hotels")
        .doc(bookingHistoryModel.hotelId)
        .get();
    _hotelSearchModel = HotelSearchModel.fromJson(querySnapshot
        .data()![bookingHistoryModel.hotelId] as Map<String, dynamic>);
    _bookingHistoryDisplayModel = BookingHistoryDisplayModel(
        bookingHistoryModel: _bookingHistoryModel!,
        hotelSearchModel: _hotelSearchModel!);
  }

  Future<void> setHotelDetails(BookingHistoryModel bookingHistoryModel) async {
    final querySnapshot = await _firebaseFirestore
        .collection(
            bookingHistoryModel.cityAndState.split(",")[1].trim().toLowerCase())
        .doc(
            bookingHistoryModel.cityAndState.split(",")[0].trim().toLowerCase())
        .collection("hotels")
        .doc(bookingHistoryModel.hotelId)
        .collection("details")
        .doc(bookingHistoryModel.hotelId)
        .get();
    _hotelDetailsModel = HotelDetailsModel.fromJson(
        querySnapshot.data()!["details"] as Map<String, dynamic>);
    print("summa");
    notifyListeners();
  }

  void setSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("bookingHistoryDisplayModel",
        _bookingHistoryDisplayModel!.toJson().toString());
    sharedPreferences.setString(
        "hotelDetailsModel", _hotelDetailsModel!.toJson().toString());
  }
}
