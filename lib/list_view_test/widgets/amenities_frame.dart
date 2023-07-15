import 'package:flutter/material.dart';

import 'amenities_widget.dart';

class AmenitiesFrameWidget extends StatelessWidget {
  const AmenitiesFrameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            children: [
              AmenitiesWidget(),
              AmenitiesWidget(),
              AmenitiesWidget(),
              AmenitiesWidget(),
            ],
          ),
        ),
        Flexible(
          child: Column(
            children: [
              AmenitiesWidget(),
              AmenitiesWidget(),
              AmenitiesWidget(),
              AmenitiesWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
