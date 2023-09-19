import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/hotel_booking/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/hotel_booking/providers/maps_provider.dart';
import 'package:practise1/hotel_booking/utils/common_helper/general_utils.dart';
import 'package:practise1/hotel_booking/widgets/booking_data_display/upcoming_assistance_widget.dart';
import 'package:provider/provider.dart';

class UpcomingHelper extends StatelessWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;
  final HotelDetailsModel hotelDetailsModel;
  const UpcomingHelper({
    super.key,
    required this.bookingHistoryDisplayModel,
    required this.hotelDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UpcomingAssistanceWidget(
            iconData: Icons.navigation_outlined,
            onPressed: () {
              Provider.of<MapProvider>(context, listen: false)
                  .openMapWithoutClick(
                context,
                hotelDetailsModel.locationDetails.hotelLocationDetails.lat,
                hotelDetailsModel.locationDetails.hotelLocationDetails.lng,
                hotelDetailsModel.locationDetails.hotelLocationDetails.name,
              );
            },
            title: "Directions",
          ),
          UpcomingAssistanceWidget(
            iconData: Icons.phone_outlined,
            onPressed: () {
              GeneralUtils.launchPhone(bookingHistoryDisplayModel
                  .hotelSearchModel.hotelContactDetails.phone);
            },
            title: "Call hotel",
          ),
          UpcomingAssistanceWidget(
            iconData: Icons.question_answer_outlined,
            onPressed: () {},
            title: "Need help?",
          ),
        ],
      ),
    );
  }
}
