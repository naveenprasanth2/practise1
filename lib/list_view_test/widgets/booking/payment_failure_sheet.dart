import 'package:flutter/material.dart';

class PaymentFailureSheet extends StatelessWidget {
  final VoidCallback initiatePayment;
  const PaymentFailureSheet({super.key, required this.initiatePayment});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning,
              color: Colors.red,
              size: 100,
            ),
            const Text("Ohh hoo, your payment failed"),
            ElevatedButton(
              onPressed: initiatePayment,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Retry'),
            ),
          ]),
    );
  }
}
