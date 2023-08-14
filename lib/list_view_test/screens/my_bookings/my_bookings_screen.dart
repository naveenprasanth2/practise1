import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/list_view_test/providers/booking_data_provider.dart';
import 'package:practise1/list_view_test/widgets/my_bookings/my_bookings_widget.dart';
import 'package:provider/provider.dart';
import '../../models/booking_history_model/booking_history_model.dart';
import '../../models/hotel_search/hotel_search_model.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen>
    with SingleTickerProviderStateMixin {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late TabController _tabController;
  List<BookingHistoryModel> myBookingHistoryList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getDetailedRatingsFromJson();
  }

  Future<void> getDetailedRatingsFromJson() async {
    // Navigate to the bookings collection of the dummy user document
    final bookingsCollection = _firebaseFirestore
        .collection("users")
        .doc("dummy")
        .collection("bookings");

    // Fetch all the documents from the bookings collection
    final QuerySnapshot bookingsSnapshot = await bookingsCollection.get();
    List<dynamic> allValues = [];

    for (var doc in bookingsSnapshot.docs) {
      Map<String, dynamic> dataMap = doc.data() as Map<String, dynamic>;
      allValues.addAll(dataMap.values);
    }

    myBookingHistoryList.addAll(
        allValues.map((value) => BookingHistoryModel.fromJson(value)).toList());
    getUpcomingList();
    getCheckedOutList();
    getCancelledList();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getUpcomingList() async {
    List<BookingHistoryDisplayModel> upcomingList = [];
    List<Future> tasks = []; // List to hold all our future tasks

    for (var element in myBookingHistoryList) {
      if (element.checkOutStatus == "booked") {
        tasks.add(
          getHotelDetails(element).then(
            (hotelDetails) => upcomingList.add(
              BookingHistoryDisplayModel(
                bookingHistoryModel: element,
                hotelSearchModel: hotelDetails,
              ),
            ),
          ),
        );
      }
    }
    // Wait for all tasks to complete
    await Future.wait(tasks).then((value) =>
        Provider.of<BookingDataProvider>(context, listen: false)
            .setUpcomingList(upcomingList));
  }

  Future<void> getCheckedOutList() async {
    List<BookingHistoryDisplayModel> checkedOutList = [];
    List<Future> tasks = []; // List to hold all our future tasks

    for (var element in myBookingHistoryList) {
      if (element.checkOutStatus == "checkedOut") {
        tasks.add(
          getHotelDetails(element).then(
            (hotelDetails) => checkedOutList.add(
              BookingHistoryDisplayModel(
                bookingHistoryModel: element,
                hotelSearchModel: hotelDetails,
              ),
            ),
          ),
        );
      }
    }

    // Wait for all tasks to complete
    await Future.wait(tasks).then((value) =>
        Provider.of<BookingDataProvider>(context, listen: false)
            .setCheckedOutList(checkedOutList));
  }

  Future<void> getCancelledList() async {
    List<BookingHistoryDisplayModel> cancelledList = [];
    List<Future> tasks = []; // List to hold all our future tasks

    for (var element in myBookingHistoryList) {
      if (element.checkOutStatus == "cancelled") {
        tasks.add(
          getHotelDetails(element).then(
            (hotelDetails) => cancelledList.add(
              BookingHistoryDisplayModel(
                bookingHistoryModel: element,
                hotelSearchModel: hotelDetails,
              ),
            ),
          ),
        );
      }
    }

    // Wait for all tasks to complete
    await Future.wait(tasks).then((value) =>
        Provider.of<BookingDataProvider>(context, listen: false)
            .setCancelledList(cancelledList));
  }

  Future<HotelSearchModel> getHotelDetails(
      BookingHistoryModel bookingHistoryModel) async {
    final querySnapshot = await _firebaseFirestore
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.red.shade400,
                  title: const Text(
                    "My Bookings",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
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
                body: Consumer<BookingDataProvider>(
                    builder: (context, bookingDataProvider, _) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      buildTabView(bookingDataProvider.upcomingList),
                      buildTabView(bookingDataProvider.checkedOutList),
                      buildTabView(bookingDataProvider.cancelledList),
                    ],
                  );
                }),
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
