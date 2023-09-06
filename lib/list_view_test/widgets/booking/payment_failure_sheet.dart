import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/booking_data_provider.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:provider/provider.dart';

class PaymentFailureSheet extends StatelessWidget {
  final VoidCallback initiatePayment;
  const PaymentFailureSheet({super.key, required this.initiatePayment});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Consumer<BookingDataProvider>(
          builder: (context, bookingDataProvider, _) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 100,
                ),
                SizedBoxHelper.sizedBox15,
                const Text("Ohh hoo, your payment failed"),
                SizedBoxHelper.sizedBox15,
                InkWell(
                  onTap: () {
                    Provider.of<BookingDataProvider>(context, listen: false)
                        .setIsRetryLoading(true);
                    initiatePayment();
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: bookingDataProvider.isRetryLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Retry',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
