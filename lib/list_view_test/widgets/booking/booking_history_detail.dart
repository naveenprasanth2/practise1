import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/utils/common_helper/general_utils.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/list_view_test/utils/string_utils.dart';
import 'package:practise1/list_view_test/widgets/booking/chat_bubble.dart';
import 'package:practise1/list_view_test/widgets/booking/show_checkin_checkout_details.dart';
import 'package:practise1/list_view_test/widgets/room_occupancy_details/add_rooms_widget.dart';

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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Booking ID",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(bookingHistoryDisplayModel
                                .bookingHistoryModel.bookingId
                                .split("_")
                                .last),
                          ],
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              GeneralUtils.copyBookingIdToClipboard(
                                  context,
                                  bookingHistoryDisplayModel
                                      .bookingHistoryModel.bookingId
                                      .split("_")
                                      .last);
                            },
                            icon: const Icon(Icons.copy),
                          ),
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
                          "Reserved for",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(bookingHistoryDisplayModel
                            .bookingHistoryModel.reservedFor),
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
                          "Rooms & Guests",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                                "${bookingHistoryDisplayModel.bookingHistoryModel.roomsCount} Rooms"),
                            SizedBoxHelper.sizedBox_10,
                            Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                            SizedBoxHelper.sizedBox_10,
                            Text(
                                "${bookingHistoryDisplayModel.bookingHistoryModel.guestsCount} Guests"),
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
                          "Room Type",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(StringUtils.convertToSentenceCaseForAll(
                            bookingHistoryDisplayModel
                                .bookingHistoryModel.roomType)),
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
