import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/providers/count_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/dart_helper/sizebox_helper.dart';

class AdultChildBottomSheet extends StatefulWidget {
  const AdultChildBottomSheet({super.key});

  @override
  AdultChildBottomSheetState createState() => AdultChildBottomSheetState();
}

class AdultChildBottomSheetState extends State<AdultChildBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter the values',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBoxHelper.sizedBox30,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Adult',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<CountProvider>(context, listen: false)
                            .decrementAdultCount();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Provider.of<CountProvider>(context, listen: true)
                          .tempAdultCount
                          .toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<CountProvider>(context, listen: false)
                            .incrementAdultCount();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Child',
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<CountProvider>(context, listen: false)
                            .decrementChildCount();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(Icons.remove),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Provider.of<CountProvider>(context, listen: false)
                          .tempChildCount
                          .toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<CountProvider>(context, listen: false)
                            .incrementChildCount();
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Provider.of<CountProvider>(context, listen: false)
                    .notifyAdultListeners();
                Provider.of<CountProvider>(context, listen: false)
                    .notifyChildListeners();
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red.shade400,
                ),
                child: const Center(
                    child: Text(
                  "submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
