import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:practise1/hotel_booking/screens/home/home_page.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

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
      duration: const Duration(seconds: 3),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Navigate to home screen when animation is completed
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (builder) => const HomeScreen()),
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
