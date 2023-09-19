import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/hotel_booking/widgets/room_occupancy_details/add_rooms_widget.dart';

class GuestDetailsWidget extends StatelessWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;
  const GuestDetailsWidget({
    super.key,
    required this.bookingHistoryDisplayModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
