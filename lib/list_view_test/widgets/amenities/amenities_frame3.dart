import 'package:flutter/material.dart';

import '../../models/amenities_model/amenities_model.dart';
import 'amenities_widget.dart';

class AmenitiesFrameWidget extends StatelessWidget {
  AmenitiesModel? amenitiesModel;
  AmenitiesFrameWidget({super.key, required this.amenitiesModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            children: [
              if(amenitiesModel?.hotelFacilitiesModel?.ac ?? false)
                const AmenitiesWidget(iconData:Icons.ac_unit,title: "AC",),
              if(amenitiesModel?.hotelFacilitiesModel?.wifi ?? false)
                const AmenitiesWidget(iconData: Icons.wifi, title: "WIFI",),
              if(amenitiesModel?.hotelFacilitiesModel?.kitchen ?? false)
                const AmenitiesWidget(iconData: Icons.kitchen, title: "Kitchen",),
              if(amenitiesModel?.hotelFacilitiesModel?.restaurant ?? false)
                const AmenitiesWidget(iconData: Icons.restaurant, title: "Restaurant",),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              if(amenitiesModel?.hotelFacilitiesModel?.reception ?? false)
                const AmenitiesWidget(iconData:Icons.table_chart,title: "Reception",),
              if(amenitiesModel?.hotelFacilitiesModel?.careTaker ?? false)
                const AmenitiesWidget(iconData: Icons.person, title: "Care Taker",),
              if(amenitiesModel?.hotelFacilitiesModel?.security ?? false)
                const AmenitiesWidget(iconData: Icons.security, title: "Security",),
              if(amenitiesModel?.hotelFacilitiesModel?.shuttleService ?? false)
                const AmenitiesWidget(iconData: Icons.airport_shuttle, title: "Shuttle Service",),
            ],
          ),
        ),
      ],
    );
  }
}
