import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/list_view_test/widgets/ratings/rating_view.dart';

class RatingDialogHelper {
  static void openRatingDialog(BuildContext context,
      BookingHistoryDisplayModel bookingHistoryDisplayModel) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: RatingView(
                bookingHistoryDisplayModel: bookingHistoryDisplayModel),
          );
        });
  }
}
