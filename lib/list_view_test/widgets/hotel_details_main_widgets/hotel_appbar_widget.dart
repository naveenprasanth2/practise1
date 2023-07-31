import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:provider/provider.dart';

import '../../providers/count_provider.dart';
import '../../providers/date_provider.dart';
import '../adult_child/adult_child_bottom_sheet.dart';

class HotelDetailsAppBar extends StatelessWidget {
  final HotelDetailsModel? hotelDetailsModel;

  const HotelDetailsAppBar({
    super.key,
    this.hotelDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      automaticallyImplyLeading: true,
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.phone),
        ),
      ],
      backgroundColor: Colors.red.shade400,
      title: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              // Use a null-aware operator to avoid null errors
              hotelDetailsModel?.hotelName ?? "Hotel Name Loading...",
              style: const TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const AdultChildBottomSheet();
                      },
                    );
                  },
                  child: Text(
                    "Adult ${Provider.of<CountProviders>(context, listen: true).adultCount} - Child ${Provider.of<CountProviders>(context, listen: true).childCount}",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    Provider.of<DateProvider>(context, listen: false)
                        .setDate(context);
                  },
                  child: Text(
                    Provider.of<DateProvider>(context, listen: true).date ??
                        Provider.of<DateProvider>(context, listen: true)
                            .initialDate!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
