import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/about_hotel_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:provider/provider.dart';

import '../../models/booking_history_model/booking_history_model.dart';
import '../../providers/calculation_provider.dart';
import '../../providers/count_provider.dart';
import '../../providers/date_provider.dart';
import '../../providers/profile_provider.dart';
import '../../utils/date_helper/date_helper.dart';
import '../booking/booking_widget.dart';
import '../hotel_details/pricing_detail_widget.dart';

class HotelDetailsBottomBar extends StatefulWidget {
  final HotelDetailsModel? hotelDetailsModel;
  final AboutHotelModel? aboutHotelModel;

  const HotelDetailsBottomBar({
    super.key,
    this.hotelDetailsModel,
    this.aboutHotelModel,
  });

  @override
  State<HotelDetailsBottomBar> createState() => _HotelDetailsBottomBarState();
}

class _HotelDetailsBottomBarState extends State<HotelDetailsBottomBar> {
  late BookingHistoryModel bookingHistoryModel;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 80,
      color: Colors.white,
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
                          hotelDetailsModel: widget.hotelDetailsModel!,
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
                  createPayloadForBooking();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return widget.aboutHotelModel != null
                          ? BookingWidget(
                              hotelDetailsModel: widget.hotelDetailsModel!,
                              bookingHistoryModel: bookingHistoryModel,
                            )
                          : const SizedBox.shrink();
                    },
                  );
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.red.shade600,
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
                        fontSize: 16,
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

  void createPayloadForBooking() {
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final CalculationProvider calculationProvider =
        Provider.of<CalculationProvider>(context, listen: false);
    final CountProvider countProvider =
        Provider.of<CountProvider>(context, listen: false);
    final DateProvider dateProvider =
        Provider.of<DateProvider>(context, listen: false);
    print(countProvider.roomsInfo.length);
    String bookingId =
        "${profileProvider.mobileNo.substring(1, profileProvider.mobileNo.length)}_${DateHelper.formatDateWithDayAndYearInNumbers(dateProvider.checkInDateWithYear)}_${DateHelper.getCurrentTime()}";
    bookingHistoryModel = BookingHistoryModel(
        amountPaid: calculationProvider.finalPriceWithPrepaidDiscount!.toInt(),
        guestsCount: countProvider.adultCount,
        checkInDate: dateProvider.checkInDateWithYear,
        checkOutDate: dateProvider.checkOutDateWithYear,
        reservedFor: profileProvider.name,
        bookingId: bookingId,
        checkInTime: "12:00PM",
        checkOutTime: "11:00AM",
        checkOutStatus: "booked",
        cityAndState: "chennai, tamilnadu",
        discount: 10,
        discountCoupon: "TTYY90",
        hotelId: widget.hotelDetailsModel!.id,
        rated: false,
        roomsCount: countProvider.roomsInfo.length);
  }
}
