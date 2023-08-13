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
  List<BookingHistoryDisplayModel> myUpcomingList = [];
  List<BookingHistoryDisplayModel> myCheckedOutList = [];
  List<BookingHistoryDisplayModel> myCancelledList = [];
  late HotelSearchModel _hotelSearchModelValue;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getDetailedRatingsFromJson();
  }

  Future<void> getDetailedRatingsFromJson() async {
    final value = await rootBundle.loadString("assets/my_bookings_data.json");
    setState(() async {
      final dynamic ratingsDetailsData = json.decode(value);

      for (var json in ratingsDetailsData) {
        myBookingHistoryList.add(BookingHistoryModel.fromJson(json));
      }
      await Future.forEach(
          myBookingHistoryList
              .where((element) => element.checkOutStatus == "booked"),
          (element) async {
        final hotelDetails = await getHotelDetails(element);
        myUpcomingList.add(BookingHistoryDisplayModel(
          bookingHistoryModel: element,
          hotelSearchModel: hotelDetails,
        ));
      });

      await Future.forEach(
          myBookingHistoryList
              .where((element) => element.checkOutStatus == "checkedOut"),
          (element) async {
        final hotelDetails = await getHotelDetails(element);
        myCheckedOutList.add(BookingHistoryDisplayModel(
          bookingHistoryModel: element,
          hotelSearchModel: hotelDetails,
        ));
      });

      await Future.forEach(
          myBookingHistoryList
              .where((element) => element.checkOutStatus == "cancelled"),
          (element) async {
        final hotelDetails = await getHotelDetails(element);
        myCancelledList.add(BookingHistoryDisplayModel(
          bookingHistoryModel: element,
          hotelSearchModel: hotelDetails,
        ));
      });
    });
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
      _hotelSearchModelValue = HotelSearchModel.fromJson(querySnapshot
          .data()![bookingHistoryModel.hotelId] as Map<String, dynamic>);
    return _hotelSearchModelValue;
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
          body: TabBarView(
            controller: _tabController,
            children: [
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Builder(builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: MyBookingsWidget(
                              bookingHistoryDisplayModel: myUpcomingList[index],
                            ),
                          );
                        });
                      },
                      childCount: myUpcomingList.length,
                    ),
                  ),
                ],
              ),
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: MyBookingsWidget(
                            bookingHistoryDisplayModel: myCheckedOutList[index],
                          ),
                        );
                      },
                      childCount: myCheckedOutList.length,
                    ),
                  ),
                ],
              ),
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: MyBookingsWidget(
                            bookingHistoryDisplayModel: myCancelledList[index],
                          ),
                        );
                      },
                      childCount: myCancelledList.length,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
