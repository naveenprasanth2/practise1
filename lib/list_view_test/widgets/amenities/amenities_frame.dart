import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/amenities_model/amenities_model.dart';

import 'amenities_widget.dart';

class AmenitiesFrameWidgetOne extends StatelessWidget {
  AmenitiesModel? amenitiesModel;

  AmenitiesFrameWidgetOne({super.key, required this.amenitiesModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            children: [
              AmenitiesWidget(
                  iconData: Icons.ac_unit,
                  title: "Ac",
                  isAvailable:
                      amenitiesModel?.hotelFacilitiesModel?.ac ?? false),
              AmenitiesWidget(
                iconData: Icons.wifi,
                title: "Wifi",
                isAvailable:
                    amenitiesModel?.hotelFacilitiesModel?.wifi ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.kitchen,
                title: "Kitchen",
                isAvailable:
                    amenitiesModel?.hotelFacilitiesModel?.kitchen ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.restaurant,
                title: "Restaurant",
                isAvailable:
                    amenitiesModel?.hotelFacilitiesModel?.restaurant ?? false,
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              AmenitiesWidget(
                iconData: Icons.table_chart,
                title: "Reception",
                isAvailable:
                    amenitiesModel?.hotelFacilitiesModel?.reception ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.person,
                title: "Care Taker",
                isAvailable:
                    amenitiesModel?.hotelFacilitiesModel?.careTaker ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.security,
                title: "Security",
                isAvailable:
                    amenitiesModel?.hotelFacilitiesModel?.security ?? false,
              ),
              AmenitiesWidget(
                iconData: Icons.airport_shuttle,
                title: "Shuttle Service",
                isAvailable:
                    amenitiesModel?.hotelFacilitiesModel?.shuttleService ??
                        false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
