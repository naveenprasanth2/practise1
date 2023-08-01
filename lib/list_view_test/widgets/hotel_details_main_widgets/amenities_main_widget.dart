import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/amenities_model/amenities_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';

import '../amenities/amenities_bottom_widget.dart';
import '../amenities/amenities_frame.dart';

class AmenitiesMainWidget extends StatelessWidget {
  final AmenitiesModel amenitiesModel;
  final HotelDetailsModel hotelDetailsModel;

  const AmenitiesMainWidget({
    super.key,
    required this.amenitiesModel,
    required this.hotelDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.grey.shade200),
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AmenitiesFrameWidgetOne(
                    amenitiesModel: amenitiesModel,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return AmenitiesBottomWidget(
                        hotelDetailsModel: hotelDetailsModel!,
                      );
                    },
                  );
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red.shade400,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
