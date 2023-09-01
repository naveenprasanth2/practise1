import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/booking_history_model/booking_history_model.dart';
import 'package:practise1/list_view_test/providers/booking_data_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/common_helper/general_utils.dart';

class BookingCancelWidget extends StatelessWidget {
  final BookingHistoryModel bookingHistoryModel;

  const BookingCancelWidget({Key? key, required this.bookingHistoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 220,
        width: MediaQuery.of(context).size.width * 0.80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Text(
                    "Are you sure?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You want to cancel the booking?",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _button(
                    "Confirm",
                    color: Colors.red.shade400,
                    onTap: () {
                      // Handle button press
                      cancelBooking(context);
                      GeneralUtils.showSuccessSnackBar(context,
                          "Cancel Successful \nRefund will be processed in 4 working days");
                      Navigator.pop(context);
                    },
                  ),
                  _button(
                    "Cancel",
                    color: Colors.grey.shade700,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(String label, {required Color color, VoidCallback? onTap}) {
    return Container(
      height: 50,
      width: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  void cancelBooking(BuildContext context) {
    bookingHistoryModel.checkOutStatus = "cancelled";
    FirebaseFirestore.instance
        .collection("users")
        .doc("dummy")
        .collection("bookings")
        .doc(bookingHistoryModel.bookingId.toString())
        .set({
      bookingHistoryModel.bookingId.toString(): bookingHistoryModel.toJson()
    });
    Provider.of<BookingDataProvider>(context, listen: false)
        .swapDataFromUpcomingToCancelledList(
            bookingHistoryModel.bookingId.toString());
  }

  void cancelBookingThroughValidatingServer(BuildContext context) {
    bookingHistoryModel.checkOutStatus = "cancelled";
    FirebaseFirestore.instance
        .collection("users")
        .doc("dummy")
        .collection("bookings")
        .doc(bookingHistoryModel.bookingId.toString())
        .set({
      bookingHistoryModel.bookingId.toString(): bookingHistoryModel.toJson()
    });
    Provider.of<BookingDataProvider>(context, listen: false)
        .swapDataFromUpcomingToCancelledList(
        bookingHistoryModel.bookingId.toString());
  }
}
