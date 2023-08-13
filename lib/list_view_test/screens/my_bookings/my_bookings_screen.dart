import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/list_view_test/widgets/my_bookings/my_bookings_widget.dart';
import '../../models/booking_history_model/booking_history_model.dart';
import '../../models/hotel_search/hotel_search_model.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<BookingHistoryModel> myBookingHistoryList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getDetailedRatingsFromJson();
  }

  Future<void> getDetailedRatingsFromJson() async {
    final value = await rootBundle.loadString("assets/my_bookings_data.json");
    setState(() {
      final dynamic ratingsDetailsData = json.decode(value);

      for (var json in ratingsDetailsData) {
        myBookingHistoryList.add(BookingHistoryModel.fromJson(json));
      }
    });
  }

  Future<List<BookingHistoryDisplayModel>> getUpcomingList() async {
    List<BookingHistoryDisplayModel> upcomingList = [];
    for (var element in myBookingHistoryList) {
      if (element.checkOutStatus == "booked") {
        final hotelDetails = await getHotelDetails(element);
        upcomingList.add(BookingHistoryDisplayModel(
          bookingHistoryModel: element,
          hotelSearchModel: hotelDetails,
        ));
      }
    }
    return upcomingList;
  }

  Future<List<BookingHistoryDisplayModel>> getCheckedOutList() async {
    List<BookingHistoryDisplayModel> checkedOutList = [];
    for (var element in myBookingHistoryList) {
      if (element.checkOutStatus == "checkedOut") {
        final hotelDetails = await getHotelDetails(element);
        checkedOutList.add(BookingHistoryDisplayModel(
          bookingHistoryModel: element,
          hotelSearchModel: hotelDetails,
        ));
      }
    }
    return checkedOutList;
  }

  Future<List<BookingHistoryDisplayModel>> getCancelledList() async {
    List<BookingHistoryDisplayModel> cancelledList = [];
    for (var element in myBookingHistoryList) {
      if (element.checkOutStatus == "cancelled") {
        final hotelDetails = await getHotelDetails(element);
        cancelledList.add(BookingHistoryDisplayModel(
          bookingHistoryModel: element,
          hotelSearchModel: hotelDetails,
        ));
      }
    }
    return cancelledList;
  }

  Future<HotelSearchModel> getHotelDetails(
      BookingHistoryModel bookingHistoryModel) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(
            bookingHistoryModel.cityAndState.split(",")[1].trim().toLowerCase())
        .doc(
            bookingHistoryModel.cityAndState.split(",")[0].trim().toLowerCase())
        .collection("hotels")
        .doc(bookingHistoryModel.hotelId)
        .get();
    return HotelSearchModel.fromJson(querySnapshot
        .data()![bookingHistoryModel.hotelId] as Map<String, dynamic>);
  }

  Stream<List<List<BookingHistoryDisplayModel>>> getAllStreams() async* {
    final upcomingList = await getUpcomingList();
    final checkedOutList = await getCheckedOutList();
    final cancelledList = await getCancelledList();

    yield [upcomingList, checkedOutList, cancelledList];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red.shade400,
            title: const Text(
              "My Bookings",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
              ),
              tabs: const [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Upcoming',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Checked Out',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Cancelled',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: StreamBuilder<List<List<BookingHistoryDisplayModel>>>(
            stream: getAllStreams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else {
                final allData = snapshot.data;
                return TabBarView(
                  controller: _tabController,
                  children: [
                    buildTabView(allData![0]),
                    buildTabView(allData[1]),
                    buildTabView(allData[2]),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildTabView(List<BookingHistoryDisplayModel> data) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: MyBookingsWidget(
                  bookingHistoryDisplayModel: data[index],
                ),
              );
            },
            childCount: data.length,
          ),
        ),
      ],
    );
  }
}
