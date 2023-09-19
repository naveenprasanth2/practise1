import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/widgets/room_occupancy_details/add_rooms_widget.dart';

class ContactDetailsWidget extends StatelessWidget {
  final String title;
  final String mobileNo;
  final String emailId;
  const ContactDetailsWidget({
    super.key,
    required this.title,
    required this.mobileNo,
    required this.emailId,
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
                  Text(mobileNo),
                  Text(emailId),
                ],
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
