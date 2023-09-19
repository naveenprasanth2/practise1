import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/utils/common_helper/general_utils.dart';
import 'package:practise1/hotel_booking/widgets/room_occupancy_details/add_rooms_widget.dart';

class BookingTileWidget extends StatelessWidget {
  final String title;
  final String value;
  final bool copyIcon;
  const BookingTileWidget({
    super.key,
    required this.title,
    required this.value,
    required this.copyIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(value),
                ],
              ),
              if (copyIcon)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      GeneralUtils.copyBookingIdToClipboard(context, value);
                    },
                    icon: const Icon(Icons.copy),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: CustomPaint(
            painter: DottedLinePainter(),
          ),
        ),
      ],
    );
  }
}
