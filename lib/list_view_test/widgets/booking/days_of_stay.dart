import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/utils/date_helper/date_helper.dart';

import '../../utils/dart_helper/sizebox_helper.dart';

class DatesOfStayContainer extends StatelessWidget {
  const DatesOfStayContainer({
    Key? key,
    required this.checkInDate,
    required this.checkOutDate,
  }) : super(key: key);

  final String checkInDate;
  final String checkOutDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Check-In',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBoxHelper.sizedBox4,
              Text(
                checkInDate,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBoxHelper.sizedBox4,
              const Text(
                "12:00PM",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: 50,
              width: 100,
              child: Center(
                child: Text(
                  DateHelper.getNoOfDaysInBetweenInShort(
                              checkInDate, checkOutDate)
                          .toString() +
                      "N".toString(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Check-Out',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBoxHelper.sizedBox4,
              Text(
                checkOutDate,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              SizedBoxHelper.sizedBox4,
              const Text(
                "11:00AM",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
