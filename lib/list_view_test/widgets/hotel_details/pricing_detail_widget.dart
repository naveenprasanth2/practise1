import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:provider/provider.dart';

class PricingDetailsWidget extends StatelessWidget {
  final HotelDetailsModel hotelDetailsModel;

  const PricingDetailsWidget({
    Key? key,
    required this.hotelDetailsModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Price Breakup & Offers Applied",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                InkWell(
                  child: const Icon(Icons.close),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${Provider.of<DateProvider>(context).noOfDays} Night",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  "${Provider.of<DateProvider>(context).noOfDays} Night",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(thickness: 2),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Pay by Cash',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Pay Online',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Room Tariff',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            Provider.of<CalculationProvider>(context,
                                    listen: true)
                                .costPerNight
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            hotelDetailsModel.roomType.standardRoom.price
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Discount Applied',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.10)
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.10)
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Pre-Tax price',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            hotelDetailsModel.roomType.standardRoom.price
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            hotelDetailsModel.roomType.standardRoom.price
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'GST ${Provider.of<CalculationProvider>(context, listen: true).gstPercentage}%',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.12)
                                .roundToDouble()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.12)
                                .roundToDouble()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Prepaid Discount',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            '-',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.10)
                                .roundToDouble()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Final Price',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.9)
                                .roundToDouble()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.8)
                                .roundToDouble()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Expanded(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Total Payable',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.9)
                                .roundToDouble()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            (hotelDetailsModel.roomType.standardRoom.price *
                                    0.8)
                                .roundToDouble()
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
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
