import 'package:flutter/material.dart';

import '../../utils/amenities_helper/amenities_helper.dart';
import 'amenities_widget.dart';

class AmenitiesIndividualWidget extends StatelessWidget {
  final Map<String, bool> values;

  const AmenitiesIndividualWidget({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AmenitiesWidget(
            iconData: AmenitiesHelper.getIconIfPresent(
              values.keys.skip(index).first,
              values.values.skip(index).first,
            ),
            title: AmenitiesHelper.amenitiesNameConverter(
                values.keys.skip(index).first),
            isAvailable: values.values.skip(index).first,
          ),
        );
      },
    );
  }
}
