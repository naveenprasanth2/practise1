import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:practise1/hotel_booking/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/hotel_booking/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/hotel_booking/widgets/booking_confirmation/booking_confirmation_widget.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;
  final HotelDetailsModel hotelDetailsModel;
  const PaymentSuccessScreen(
      {super.key,
      required this.bookingHistoryDisplayModel,
      required this.hotelDetailsModel});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Navigate to home screen when animation is completed
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) => BookingConfirmationWidget(
                      bookingHistoryDisplayModel:
                          widget.bookingHistoryDisplayModel,
                      hotelDetailsModel: widget.hotelDetailsModel,
                    )),
          );
        }
      })
      ..forward(); // Start the animation on initialization
  }

  @override
  void dispose() {
    _controller.dispose(); // Make sure to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'lottie_assets/success_tick.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
          },
        ),
      ),
    );
  }
}
