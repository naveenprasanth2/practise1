import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/utils/common_helper/general_utils.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/hotel_booking/utils/string_utils.dart';
import 'package:practise1/hotel_booking/widgets/booking/show_checkin_checkout_details.dart';
import 'package:practise1/hotel_booking/widgets/booking_data_display/booking_tile_widget.dart';
import 'package:practise1/hotel_booking/widgets/booking_data_display/guest_details_widget.dart';
import 'package:practise1/hotel_booking/widgets/room_occupancy_details/add_rooms_widget.dart';

import '../../models/booking_history_model/booking_history_display_model.dart';
import '../../screens/hotel_booking/hotel_detail_screen.dart';

class BookingHistoryDetailWidget extends StatelessWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;

  const BookingHistoryDetailWidget(
      {super.key, required this.bookingHistoryDisplayModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.transparent),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    "Booking Details",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ],
          ),
          Expanded(
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
                      SizedBoxHelper.sizedBox_10,
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
                                Text(bookingHistoryDisplayModel.hotelSearchModel
                                    .hotelLocationDetails.address),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBoxHelper.sizedBox20,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => HotelDetailScreen(
                              hotelSearchModel:
                                  bookingHistoryDisplayModel.hotelSearchModel,
                              cityAndState: bookingHistoryDisplayModel
                                  .bookingHistoryModel.cityAndState),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Book again ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
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
                  SizedBox(
                    width: double.infinity,
                    child: CustomPaint(
                      painter: DottedLinePainter(),
                    ),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Contact us",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Contact bookAny"),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      GeneralUtils.launchPhone(bookingHistoryDisplayModel
                          .hotelSearchModel.hotelContactDetails.phone);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Contact Property Desk"),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ],
                      ),
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
        ],
      ),
    );
  }
}
