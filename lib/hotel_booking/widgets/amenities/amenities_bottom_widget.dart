import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/hotel_booking/widgets/amenities/amenities_individual.dart';

class AmenitiesBottomWidget extends StatefulWidget {
  final HotelDetailsModel hotelDetailsModel;

  const AmenitiesBottomWidget({
    Key? key,
    required this.hotelDetailsModel,
  }) : super(key: key);

  @override
  State<AmenitiesBottomWidget> createState() => _AmenitiesBottomWidgetState();
}

class _AmenitiesBottomWidgetState extends State<AmenitiesBottomWidget>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> tabs = [
    "Bed Type",
    "Hotel Facilities",
    "Media & Technology",
    "Room Facility",
    "Washroom",
    "Seating Area",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  expandedHeight: 140,
                  bottom: TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    indicatorColor: Colors.red.shade400,
                    controller: _tabController,
                    tabs: tabs.map((value) => Tab(text: value)).toList(),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      AmenitiesIndividualWidget(
                        values: widget.hotelDetailsModel.amenities.bedTypeModel!
                            .bedTypeModelData(),
                      ),
                      AmenitiesIndividualWidget(
                        values: widget
                            .hotelDetailsModel.amenities.hotelFacilitiesModel!
                            .hotelFacilitiesModelData(),
                      ),
                      AmenitiesIndividualWidget(
                        values: widget
                            .hotelDetailsModel.amenities.mediaTechnologyModel!
                            .mediaTechnologyModelData(),
                      ),
                      AmenitiesIndividualWidget(
                        values: widget
                            .hotelDetailsModel.amenities.roomFacilityModel!
                            .roomFacilityModelData(),
                      ),
                      AmenitiesIndividualWidget(
                        values: widget
                            .hotelDetailsModel.amenities.washroomModel!
                            .washroomModelData(),
                      ),
                      AmenitiesIndividualWidget(
                        values: widget
                            .hotelDetailsModel.amenities.seatingAreaModel!
                            .seatingAreaModelData(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
