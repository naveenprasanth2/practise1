import 'package:flutter/material.dart';

import '../../models/booking_history_model/booking_history_model.dart';

class MyBookingsWidget extends StatelessWidget {
  final BookingHistoryModel bookingHistoryModel;

  const MyBookingsWidget({Key? key, required this.bookingHistoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 190,
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black26,
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const Image(
                        image: NetworkImage(
                          "https://media.istockphoto.com/id/187363337/photo/modern-hotel-building-in-summer.jpg?s=1024x1024&w=is&k=20&c=eAOaQqAgWgAKxRcqW3ahTsB6zhZ-ieNW_y4_POUUxgI=",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookingHistoryModel.cityName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              '${bookingHistoryModel.checkInDate} - ${bookingHistoryModel.checkOutDate}  ',
                            ),
                            Container(
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                border: Border.all(color: Colors.black),
                              ),
                            ),
                            Text(
                              "  ${bookingHistoryModel.guestsCount} Guests",
                            ),
                          ],
                        ),
                        Text(bookingHistoryModel.hotelName),
                        SizedBox(
                          height: 40, // Adjust the height as needed
                          child: Text(
                            "${bookingHistoryModel.doorNumber}, ${bookingHistoryModel.streetNumber}",
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 120,
                    margin: const EdgeInsets.all(2),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        Text(
                          "Book again",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 120,
                    margin: const EdgeInsets.all(2),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.question_answer,
                          color: Colors.black,
                        ),
                        Text(
                          "Need help?",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
