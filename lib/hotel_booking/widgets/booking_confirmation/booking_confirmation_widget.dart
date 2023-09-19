import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/hotel_booking/screens/home/home_page.dart';
import 'package:practise1/hotel_booking/utils/common_helper/general_utils.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/hotel_booking/utils/string_utils.dart';
import 'package:practise1/hotel_booking/widgets/booking_data_display/booking_tile_widget.dart';
import 'package:practise1/hotel_booking/widgets/booking/show_checkin_checkout_details.dart';
import 'package:practise1/hotel_booking/widgets/booking_data_display/guest_details_widget.dart';
import 'package:practise1/hotel_booking/widgets/room_occupancy_details/add_rooms_widget.dart';

class BookingConfirmationWidget extends StatelessWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;
  const BookingConfirmationWidget(
      {super.key, required this.bookingHistoryDisplayModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.green,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Booking Confirmed",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const HomeScreen(),
                            ),
                            (route) => false);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBoxHelper.sizedBox20,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              image: NetworkImage(bookingHistoryDisplayModel
                                  .hotelSearchModel.hotelImages[0]),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBoxHelper.sizedBox_20,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bookingHistoryDisplayModel
                                    .hotelSearchModel.hotelLocationDetails.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  Text(bookingHistoryDisplayModel
                                      .hotelSearchModel
                                      .hotelLocationDetails
                                      .address),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBoxHelper.sizedBox20,
                    SizedBox(
                      width: double.infinity,
                      child: CustomPaint(
                        painter: DottedLinePainter(),
                      ),
                    ),
                    ShowCheckInCheckOutDetailsWidget(
                      bookingHistoryDisplayModel: bookingHistoryDisplayModel,
                    ),
                    BookingTileWidget(
                      title: "Booking ID",
                      value: bookingHistoryDisplayModel
                          .bookingHistoryModel.bookingId
                          .split("_")
                          .last,
                      copyIcon: true,
                    ),
                    BookingTileWidget(
                        title: "Reserved for",
                        value: bookingHistoryDisplayModel
                            .bookingHistoryModel.reservedFor,
                        copyIcon: false),
                    GuestDetailsWidget(
                      bookingHistoryDisplayModel: bookingHistoryDisplayModel,
                    ),
                    BookingTileWidget(
                        title: "Room Type",
                        value: StringUtils.convertToSentenceCaseForAll(
                            bookingHistoryDisplayModel
                                .bookingHistoryModel.roomType),
                        copyIcon: false),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Payment Details",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Amount paid"),
                                  SizedBoxHelper.sizedBox_10,
                                  IconButton(
                                    onPressed: () {
                                      // Todo need to work here for the info button
                                      print("test");
                                    },
                                    icon: const Icon(Icons.info_outline),
                                  ),
                                ],
                              ),
                              SizedBoxHelper.sizedBox_10,
                              Text(
                                "₹ ${bookingHistoryDisplayModel.bookingHistoryModel.amountPaid}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomPaint(
                        painter: DottedLinePainter(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
