import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/about_hotel_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:provider/provider.dart';

import '../../providers/calculation_provider.dart';
import '../booking/booking_widget.dart';
import '../hotel_details/pricing_detail_widget.dart';

class HotelDetailsBottomBar extends StatelessWidget {
  final HotelDetailsModel? hotelDetailsModel;
  final AboutHotelModel? aboutHotelModel;

  const HotelDetailsBottomBar({
    super.key,
    this.hotelDetailsModel,
    this.aboutHotelModel,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Text(
                    "₹ ${Provider.of<CalculationProvider>(context, listen: true).finalPriceWithoutPrepaidDiscount ?? 0}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return PricingDetailsWidget(
                          hotelDetailsModel: hotelDetailsModel!,
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: const Icon(Icons.info_outline),
                  ),
                ),
              ],
            ),
            Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return aboutHotelModel != null
                          ? BookingWidget(
                              hotelDetailsModel: hotelDetailsModel!,
                            )
                          : const SizedBox.shrink();
                    },
                  );
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
