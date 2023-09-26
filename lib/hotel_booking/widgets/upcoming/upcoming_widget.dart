import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/hotel_booking/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/hotel_booking/widgets/booking_data_display/upcoming_helper.dart';

class UpcomingWidget extends StatelessWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;
  final HotelDetailsModel hotelDetailsModel;
  const UpcomingWidget({
    super.key,
    required this.bookingHistoryDisplayModel,
    required this.hotelDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Your Upcoming stay",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBoxHelper.sizedBox10,
          SingleChildScrollView(
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
                UpcomingHelper(
                  hotelDetailsModel: hotelDetailsModel,
                  bookingHistoryDisplayModel: bookingHistoryDisplayModel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
