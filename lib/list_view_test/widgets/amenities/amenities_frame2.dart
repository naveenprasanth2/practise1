import 'package:flutter/material.dart';

import '../../models/amenities_model/amenities_model.dart';
import 'amenities_widget.dart';

class AmenitiesFrameWidgetTwo extends StatelessWidget {
  AmenitiesModel? amenitiesModel;
  AmenitiesFrameWidgetTwo({super.key, required this.amenitiesModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            children: [
              AmenitiesWidget(
                iconData: Icons.luggage,
                title: "Luggage Assistance",
                isAvailable:
                amenitiesModel?.hotelFacilitiesModel?.luggageAssistance ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.local_taxi,
                title: "Taxi",
                isAvailable:
                amenitiesModel?.hotelFacilitiesModel?.taxi ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.person,
                title: "Daily House Keeping",
                isAvailable:
                amenitiesModel?.hotelFacilitiesModel?.dailyHousekeeping ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.medical_services_rounded,
                title: "First Aid Kit",
                isAvailable:
                amenitiesModel?.hotelFacilitiesModel?.firstAidKit ??
                    false,
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              AmenitiesWidget(
                iconData: Icons.bed,
                title: "Cot",
                isAvailable:
                amenitiesModel?.bedTypeModel?.cot ?? false,
              ),
              if(amenitiesModel?.bedTypeModel?.kingSizedBed ?? false)
              AmenitiesWidget(
                iconData: Icons.king_bed,
                title: "King Bed",
                isAvailable:
                amenitiesModel?.bedTypeModel?.kingSizedBed ?? false,
              ),
              if(amenitiesModel?.bedTypeModel?.queenSizedBed ?? false)
              AmenitiesWidget(
                iconData: Icons.king_bed_outlined,
                title: "Queen Sized Bed",
                isAvailable:
                amenitiesModel?.bedTypeModel?.queenSizedBed ?? false,
              ),
              if(amenitiesModel?.bedTypeModel?.singleBed ?? false)
              AmenitiesWidget(
                iconData: Icons.single_bed,
                title: "Single Bed",
                isAvailable:
                amenitiesModel?.bedTypeModel?.singleBed ??
                    false,
              ),
              AmenitiesWidget(
                iconData: Icons.tv,
                title: "Tv",
                isAvailable:
                amenitiesModel?.mediaTechnologyModel?.tv ??
                    false,
              ),
              AmenitiesWidget(
                iconData: Icons.settings_input_antenna,
                title: "OTT",
                isAvailable:
                amenitiesModel?.mediaTechnologyModel?.ott ??
                    false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
