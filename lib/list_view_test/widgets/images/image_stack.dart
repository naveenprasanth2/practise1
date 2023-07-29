import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';

import '../../screens/hotel_booking/images_categorization_page.dart';

Widget imageStack(String tabName, String imageUrl,
    HotelDetailsModel hotelDetailsModel, BuildContext context) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return HotelImagesBottomSheet(
                hotelImagesModel: hotelDetailsModel!.hotelImages,
                tabName: tabName,
              );
            },
          );
        },
        child: SizedBox(
          height: 60,
          width: 90,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
      Text(
        tabName,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}