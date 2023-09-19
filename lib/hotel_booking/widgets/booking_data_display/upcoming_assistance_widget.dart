import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';

class UpcomingAssistanceWidget extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final String title;
  final bool rotate;
  const UpcomingAssistanceWidget({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.title,
    required this.rotate,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade100,
            ),
            child: rotate
                ? Transform.rotate(
                    angle: pi / 4, // 45-degree rotation
                    child: Icon(
                      iconData,
                    ),
                  )
                : Icon(
                    iconData,
                  ),
          ),
          SizedBoxHelper.sizedBox4,
          Text(title),
        ],
      ),
    );
  }
}
