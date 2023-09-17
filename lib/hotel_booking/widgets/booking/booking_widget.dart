import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/booking_history_model/booking_history_model.dart';
import 'package:practise1/hotel_booking/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/hotel_booking/providers/booking_data_provider.dart';
import 'package:practise1/hotel_booking/providers/calculation_provider.dart';
import 'package:practise1/hotel_booking/providers/count_provider.dart';
import 'package:practise1/hotel_booking/providers/date_provider.dart';
import 'package:practise1/hotel_booking/providers/profile_provider.dart';
import 'package:practise1/hotel_booking/screens/my_bookings/my_bookings_screen.dart';
import 'package:practise1/hotel_booking/utils/common_helper/general_utils.dart';
import 'package:practise1/hotel_booking/utils/string_utils.dart';
import 'package:practise1/hotel_booking/widgets/booking/days_of_stay.dart';
import 'package:practise1/hotel_booking/widgets/booking/payment_failure_sheet.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class BookingWidget extends StatefulWidget {
  final HotelDetailsModel hotelDetailsModel;
  final BookingHistoryModel bookingHistoryModel;
  final BuildContext detailsScreenContext;

  const BookingWidget({
    Key? key,
    required this.hotelDetailsModel,
    required this.bookingHistoryModel,
    required this.detailsScreenContext,
  }) : super(key: key);

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
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentError);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Provider.of<BookingDataProvider>(context, listen: false)
        .setIsPayNowLoading(false);
    Provider.of<BookingDataProvider>(context, listen: false)
        .setIsRetryLoading(false);
    print("success");
    GeneralUtils.showSuccessSnackBar(context, "Your booking is successful");
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
    print("failure");
    showDialog(
      context: context,
      builder: (context) =>
          PaymentFailureSheet(initiatePayment: initiateOnlinePayment),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingDataProvider>(
      builder: (context, bookingProvider, _) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.80,
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                title: const Text(
                  'Booking Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    bookingDetailRow(
                        "Hotel Name:", widget.hotelDetailsModel.hotelName),
                    bookingDetailRow("Guest Name:",
                        Provider.of<ProfileProvider>(context).reservedFor!),
                    bookingDetailRow(
                        "Rooms:",
                        Provider.of<CalculationProvider>(context)
                            .roomsInfo
                            .length
                            .toString()),
                    bookingDetailRow(
                        "Adult:",
                        Provider.of<CountProvider>(context)
                            .adultCount
                            .toString()),
                    bookingDetailRow(
                        "Child:",
                        Provider.of<CountProvider>(context)
                            .childCount
                            .toString()),
                    bookingDetailRow(
                      "Room Type:",
                      StringUtils.convertToSentenceCase(
                        Provider.of<CalculationProvider>(context)
                            .roomSelection
                            .roomType
                            .toString(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    DatesOfStayContainer(
                      checkInDate:
                          Provider.of<DateProvider>(context).checkInDate,
                      checkOutDate:
                          Provider.of<DateProvider>(context).checkOutDate,
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: () async {
                        Provider.of<BookingDataProvider>(context, listen: false)
                            .setIsPayNowLoading(true);
                        setPaymentMode("online");
                        await handleBookingForOnlinePayment();
                      },
                      child: paymentOption(
                          "Pay Now",
                          Provider.of<CalculationProvider>(context)
                              .finalPriceWithPrepaidDiscount
                              .toString(),
                          Colors.red.shade400,
                          loading: bookingProvider.isPayNowLoading),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () async {
                        Provider.of<BookingDataProvider>(context, listen: false)
                            .setIsPayAtHotelLoading(true);
                        setPaymentMode("cash");
                        await handleBookingForCashPayment();
                      },
                      child: paymentOption(
                          "Pay at Hotel",
                          Provider.of<CalculationProvider>(context)
                              .finalPriceWithoutPrepaidDiscount
                              .toString(),
                          Colors.pinkAccent.shade100,
                          loading: bookingProvider.isPayAtHotelLoading),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bookingDetailRow(String label, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
          Text(detail, style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  Widget paymentOption(String label, String price, Color color,
      {bool loading = false}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: loading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  price,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
    );
  }

  void setPaymentMode(String paymentMode) {
    widget.bookingHistoryModel.paymentMode = paymentMode;
  }

  Future<void> handleBookingForCashPayment() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final statusCode = await postDataToDatabaseForCashPayment();
    if (mounted) {
      Provider.of<BookingDataProvider>(context, listen: false)
          .setIsPayAtHotelLoading(false);
      Navigator.pop(context);
      if (statusCode == 200) {
        GeneralUtils.showSuccessSnackBarUsingScaffold(
            scaffoldMessenger, "Your booking is successful");
      } else {
        GeneralUtils.showFailureSnackBarUsingScaffold(
            scaffoldMessenger, "Your booking is unsuccessful");
      }
    }
  }

  Future<void> handleBookingForOnlinePayment() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final statusCode = await postDataToDatabaseForOnlinePayment();
    if (mounted) {
      if (statusCode == 200) {
        initiateOnlinePayment();
      } else {
        GeneralUtils.showFailureSnackBarUsingScaffold(
            scaffoldMessenger, "Your booking is unsuccessful");
      }
    }
  }

  Future<int> postDataToDatabaseForCashPayment() async {
    const String url =
        "https://us-central1-bookany.cloudfunctions.net/processBookingDataForCashPayment";
    //posting the data
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(widget.bookingHistoryModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode;
  }

  Future<int> postDataToDatabaseForOnlinePayment() async {
    const String url =
        "https://us-central1-bookany.cloudfunctions.net/processBookingDataForOnlinePayment";
    //posting the data
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(widget.bookingHistoryModel.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode;
  }

  void initiateOnlinePayment() {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    var options = {
      'key': 'rzp_test_w1r1PYTH0wy118',
      'amount': (Provider.of<CalculationProvider>(context, listen: false)
              .finalPriceWithPrepaidDiscount!) *
          100,
      'name': 'BookAny',
      'description': widget.bookingHistoryModel.bookingId,
      'prefill': {
        'contact': profileProvider.mobileNo,
        'email': profileProvider.emailId,
      },
      'userId': profileProvider.mobileNo,
      'external': {
        'wallets': ['paytm'],
      },
    };
    _razorpay.open(options);
  }
}
