import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_search/hotel_search_model.dart';
import 'package:practise1/list_view_test/utils/rating_helper/rating_dialog_helper.dart';

import '../../models/booking_history_model/booking_history_model.dart';

class MyBookingsWidget extends StatefulWidget {
  final BookingHistoryModel bookingHistoryModel;

  const MyBookingsWidget({
    Key? key,
    required this.bookingHistoryModel,
  }) : super(key: key);

  @override
  State<MyBookingsWidget> createState() => _MyBookingsWidgetState();
}

class _MyBookingsWidgetState extends State<MyBookingsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                            "widget.hotelSearchModel.hotelImages[0]"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "summa",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.bookingHistoryModel.checkInDate} - ${widget.bookingHistoryModel.checkOutDate}  ',
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
                              "  ${widget.bookingHistoryModel.guestsCount} Guests",
                            ),
                          ],
                        ),
                        const Text("test"),
                        const SizedBox(
                          height: 40, // Adjust the height as needed
                          child: Text(
                            "${32}, ${"plot 33"}",
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    margin: const EdgeInsets.all(2),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Book again",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  if (widget.bookingHistoryModel.checkOutStatus == "booked")
                    Container(
                      height: 50,
                      width: 120,
                      margin: const EdgeInsets.all(2),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  if (widget.bookingHistoryModel.checkOutStatus ==
                          "checkedOut" &&
                      widget.bookingHistoryModel.rated == false)
                    InkWell(
                      onTap: () => RatingDialogHelper.openRatingDialog(context),
                      child: Container(
                        height: 50,
                        width: 120,
                        margin: const EdgeInsets.all(2),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.star_border_outlined,
                              color: Colors.black,
                            ),
                            Text(
                              "Rate Now",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (widget.bookingHistoryModel.checkOutStatus ==
                          "checkedOut" &&
                      widget.bookingHistoryModel.rated == true)
                    Container(
                      height: 50,
                      width: 120,
                      margin: const EdgeInsets.all(2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow.shade300,
                          ),
                          const Text(
                            "Rated",
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
