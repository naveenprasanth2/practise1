import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:provider/provider.dart';

class CancellationPolicyWidget extends StatelessWidget {
  const CancellationPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cancellation Policy",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (Provider.of<DateProvider>(context).isPastADay())
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                                shape: BoxShape.circle),
                            child: const Center(
                              child: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Free cancellation till ${Provider.of<DateProvider>(context).dateInFullLengthFormat}, 9:00AM",
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (!Provider.of<DateProvider>(context).isPastADay())
                  const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: Center(
                              child: Icon(
                                Icons.warning_amber,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("This booking is non refundable"),
                                Text(
                                  "Amount paid will not be refunded as booking and check-in happens in less than 24 hours",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                if (Provider.of<DateProvider>(context).isPastADay())
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                        width: 25,
                        child: Center(
                          child: Icon(
                            Icons.warning_amber,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No refund after ${Provider.of<DateProvider>(context).dateInFullLengthFormat}, 9:00AM",
                              style: TextStyle(color: Colors.red.shade400),
                            ),
                            const Text(
                                "100% of booking amount will be charged upon cancellation"),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (!Provider.of<DateProvider>(context).isPastADay())
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                        width: 25,
                        child: Center(
                          child: Icon(
                            Icons.lock_outline,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Free cancellation was available till ${Provider.of<DateProvider>(context).dateInFullLengthFormat}, 9:00AM",
                              style: TextStyle(color: Colors.red.shade400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                const Divider(
                  thickness: 0.5,
                ),
                const Text(
                    "In case you are no show at the property there will not be any refund in any form"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
