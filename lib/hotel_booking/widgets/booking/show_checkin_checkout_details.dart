import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/widgets/room_occupancy_details/add_rooms_widget.dart';

import '../../models/booking_history_model/booking_history_display_model.dart';
import '../../utils/date_helper/date_helper.dart';

class ShowCheckInCheckOutDetailsWidget extends StatelessWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;
  const ShowCheckInCheckOutDetailsWidget(
      {super.key, required this.bookingHistoryDisplayModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Check In",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateHelper.formatDateWithDayAndYear(
                          bookingHistoryDisplayModel
                              .bookingHistoryModel.checkInDate,
                        ),
                      ),
                      Text(
                        bookingHistoryDisplayModel
                            .bookingHistoryModel.checkInTime,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${DateHelper.getNoOfDaysInBetween(bookingHistoryDisplayModel.bookingHistoryModel.checkInDate, bookingHistoryDisplayModel.bookingHistoryModel.checkOutDate)}N",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        DateHelper.formatDateWithDayAndYear(
                          bookingHistoryDisplayModel
                              .bookingHistoryModel.checkOutDate,
                        ),
                      ),
                      Text(
                        bookingHistoryDisplayModel
                            .bookingHistoryModel.checkOutTime,
                      ),
                    ],
                  ),
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
      ],
    );
  }
}
