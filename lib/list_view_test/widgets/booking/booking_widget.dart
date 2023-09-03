import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/booking_history_model/booking_history_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/list_view_test/providers/booking_data_provider.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/providers/count_provider.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:practise1/list_view_test/screens/my_bookings/my_bookings_screen.dart';
import 'package:practise1/list_view_test/widgets/booking/payment_failure_sheet.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../models/booking_history_model/booking_history_splitter.dart';
import 'days_of_stay.dart';

class BookingWidget extends StatefulWidget {
  final HotelDetailsModel hotelDetailsModel;
  final BookingHistoryModel bookingHistoryModel;
  final BuildContext detailsScreenContext;

  const BookingWidget(
      {Key? key,
      required this.hotelDetailsModel,
      required this.bookingHistoryModel,
      required this.detailsScreenContext})
      : super(key: key);

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  late Razorpay _razorpay;
  late String orderId;

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Provider.of<BookingDataProvider>(context, listen: false)
        .setIsPayNowLoading(false);
    Provider.of<BookingDataProvider>(context, listen: false)
        .setIsRetryLoading(false);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (builder) => const MyBookingsScreen()),
        (route) => route.isFirst);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Provider.of<BookingDataProvider>(context, listen: false)
        .setIsPayNowLoading(false);
    Provider.of<BookingDataProvider>(context, listen: false)
        .setIsRetryLoading(false);
    showDialog(
      context: context,
      builder: (context) =>
          PaymentFailureSheet(initiatePayment: initiatePayment),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingDataProvider>(
        builder: (context, bookingProvider, _) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.90,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed here
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Hotel Name:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      widget.hotelDetailsModel.hotelName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed here
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Guest Name:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      Provider.of<ProfileProvider>(context).reservedFor!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Changed here
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Adult:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      Provider.of<CountProvider>(context).adultCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Changed here
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Child:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      Provider.of<CountProvider>(context).childCount.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DatesOfStayContainer(
                    checkInDate: Provider.of<DateProvider>(context).checkInDate,
                    checkOutDate:
                        Provider.of<DateProvider>(context).checkOutDate,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Pay at Hotel",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            Provider.of<CalculationProvider>(context)
                                .finalPriceWithoutPrepaidDiscount
                                .toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // sendBookingData();
                      Provider.of<BookingDataProvider>(context, listen: false)
                          .setIsPayNowLoading(true);
                      initiatePayment();
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: bookingProvider.isPayNowLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              ))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Pay Now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    Provider.of<CalculationProvider>(context)
                                        .finalPriceWithPrepaidDiscount
                                        .toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  void initiatePayment() {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    var options = {
      'key': 'rzp_test_w1r1PYTH0wy118',
      'amount': (Provider.of<CalculationProvider>(context, listen: false)
              .finalPriceWithPrepaidDiscount!) *
          100, // Amount in paise (e.g., for ₹10, amount should be 1000)
      'name': 'BookAny',
      'description': widget.bookingHistoryModel.bookingId,
      'prefill': {
        'contact': profileProvider.mobileNo,
        'email': profileProvider.emailId,
      },
      'userId': profileProvider.mobileNo,
      'external': {
        'wallets': ['paytm'] // You can specify supported wallets
      },
      'notes': {
        'hotelDetails': jsonEncode(
            HotelDetailsSplitJson.fromBookingHistoryModel(
                    widget.bookingHistoryModel)
                .toJson()),
        'bookingSchedule': jsonEncode(
            BookingScheduleSplitJson.fromBookingHistoryModel(
                    widget.bookingHistoryModel)
                .toJson()),
        'bookingStatus': jsonEncode(
            BookingStatusSplitJson.fromBookingHistoryModel(
                    widget.bookingHistoryModel)
                .toJson()),
        'paymentDetails': jsonEncode(
            PaymentDetailsSplitJson.fromBookingHistoryModel(
                    widget.bookingHistoryModel)
                .toJson()),
      }
    };
    _razorpay.open(options);
  }

  void sendBookingData() {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore
        .collection("users")
        .doc(Provider.of<ProfileProvider>(context, listen: false).mobileNo)
        .collection("bookings")
        .doc(widget.bookingHistoryModel.bookingId)
        .set({
      widget.bookingHistoryModel.bookingId: widget.bookingHistoryModel.toJson()
    });
  }
}
