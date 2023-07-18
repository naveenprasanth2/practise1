import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/widgets/my_bookings/my_bookings_widget.dart';
import '../../models/booking_history_model/booking_history_model.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<BookingHistoryModel> myBookingHistoryList = [];
  List<BookingHistoryModel> myUpcomingList = [];
  List<BookingHistoryModel> myCheckedOutList = [];
  List<BookingHistoryModel> myCancelledList = [];

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
      myUpcomingList = myBookingHistoryList
          .where((element) => element.checkOutStatus == "booked")
          .toList();

      myCheckedOutList = myBookingHistoryList
          .where((element) => element.checkOutStatus == "checkedOut")
          .toList();

      myCancelledList = myBookingHistoryList
          .where((element) => element.checkOutStatus == "cancelled")
          .toList();
    });
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
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
                        fontSize: 16.0,
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
                        fontSize: 16.0,
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
                        fontSize: 16.0,
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: MyBookingsWidget(
                            bookingHistoryModel: myUpcomingList[index],
                          ),
                        );
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
                            bookingHistoryModel: myCheckedOutList[index],
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
                            bookingHistoryModel: myCancelledList[index],
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
