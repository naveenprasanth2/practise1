import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/screens/hotel_booking/hotel_detail_screen.dart';
import 'package:practise1/list_view_test/utils/date_helper/date_helper.dart';
import 'package:practise1/list_view_test/utils/rating_helper/rating_dialog_helper.dart';
import 'package:practise1/list_view_test/widgets/booking/booking_cancel.dart';
import 'package:practise1/list_view_test/widgets/booking/booking_history_detail.dart';

import '../../models/booking_history_model/booking_history_display_model.dart';
import '../../utils/dart_helper/sizebox_helper.dart';

class MyBookingsWidget extends StatefulWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MyBookingsWidget({
    Key? key,
    required this.bookingHistoryDisplayModel,
    required this.scaffoldKey,
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => HotelDetailScreen(
                              hotelSearchModel: widget
                                  .bookingHistoryDisplayModel.hotelSearchModel,
                              cityAndState: widget.bookingHistoryDisplayModel
                                  .bookingHistoryModel.cityAndState),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage(widget.bookingHistoryDisplayModel
                              .hotelSearchModel.hotelImages[0]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        widget.scaffoldKey.currentState!.showBottomSheet(
                            backgroundColor: Colors.white, (context) {
                          return BookingHistoryDetailWidget(
                            bookingHistoryDisplayModel:
                                widget.bookingHistoryDisplayModel,
                          );
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.bookingHistoryDisplayModel.hotelSearchModel
                                .hotelLocationDetails.name,
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
                                '${DateHelper.formatDateWithDay(widget.bookingHistoryDisplayModel.bookingHistoryModel.checkInDate)} - ${DateHelper.formatDateWithDay(widget.bookingHistoryDisplayModel.bookingHistoryModel.checkOutDate)}  ',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.bookingHistoryDisplayModel.bookingHistoryModel.guestsCount} Guests",
                              ),
                              SizedBoxHelper.sizedBox_10,
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
                                "  ${widget.bookingHistoryDisplayModel.bookingHistoryModel.roomsCount} Rooms",
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(widget
                                  .bookingHistoryDisplayModel
                                  .hotelSearchModel
                                  .hotelLocationDetails
                                  .address),
                            ],
                          ),
                        ],
                      ),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => HotelDetailScreen(
                              hotelSearchModel: widget
                                  .bookingHistoryDisplayModel.hotelSearchModel,
                              cityAndState: widget.bookingHistoryDisplayModel
                                  .bookingHistoryModel.cityAndState),
                        ),
                      );
                    },
                    child: Container(
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
                  ),
                  if (widget.bookingHistoryDisplayModel.bookingHistoryModel
                          .checkOutStatus ==
                      "booked")
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BookingCancelWidget(
                              bookingHistoryModel: widget
                                  .bookingHistoryDisplayModel
                                  .bookingHistoryModel,
                            );
                          },
                        );
                      },
                      child: Container(
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
                    ),
                  if (widget.bookingHistoryDisplayModel.bookingHistoryModel
                              .checkOutStatus ==
                          "checkedOut" &&
                      widget.bookingHistoryDisplayModel.bookingHistoryModel
                              .rated ==
                          false)
                    InkWell(
                      onTap: () {
                        RatingDialogHelper.openRatingDialog(
                            context, widget.bookingHistoryDisplayModel);
                      },
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
                  if (widget.bookingHistoryDisplayModel.bookingHistoryModel
                              .checkOutStatus ==
                          "checkedOut" &&
                      widget.bookingHistoryDisplayModel.bookingHistoryModel
                              .rated ==
                          true)
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
