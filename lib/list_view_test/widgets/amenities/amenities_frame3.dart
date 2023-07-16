import 'package:flutter/material.dart';

import '../../models/amenities_model/amenities_model.dart';
import 'amenities_widget.dart';

class AmenitiesFrameWidgetThree extends StatelessWidget {
  AmenitiesModel? amenitiesModel;
  AmenitiesFrameWidgetThree({super.key, required this.amenitiesModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            children: [
              AmenitiesWidget(
                  iconData: Icons.water,
                  title: "Geyser",
                  isAvailable:
                  amenitiesModel?.washroomModel?.geyser ?? false),
              AmenitiesWidget(
                iconData: Icons.hotel,
                title: "Bedsheet",
                isAvailable:
                amenitiesModel?.roomFacilityModel?.extraMattress ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.smoking_rooms,
                title: "Smoke Detector",
                isAvailable:
                amenitiesModel?.roomFacilityModel?.smokeDetector ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.phone,
                title: "Intercom",
                isAvailable:
                amenitiesModel?.roomFacilityModel?.interCom ?? false,
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              AmenitiesWidget(
                iconData: Icons.book,
                title: "Books",
                isAvailable:
                amenitiesModel?.roomFacilityModel?.books ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.event_seat,
                title: "Seating area",
                isAvailable:
                amenitiesModel?.seatingAreaModel?.seatingArea ?? false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
