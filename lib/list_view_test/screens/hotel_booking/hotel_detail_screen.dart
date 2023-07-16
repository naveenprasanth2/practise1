import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/amenities_model/amenities_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model.dart';
import 'package:practise1/list_view_test/widgets/amenities/amenities_frame1.dart';
import 'package:practise1/list_view_test/widgets/amenities/amenities_frame2.dart';
import 'package:practise1/list_view_test/widgets/hotel_details/hotel_details.dart';

import '../../widgets/amenities/amenities_frame3.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelDetailsModel hotelDetailsModel;

  const HotelDetailScreen({super.key, required this.hotelDetailsModel});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  AmenitiesModel? amenitiesModel;
  List<MapEntry<String, dynamic>>? hotelDetails;

  @override
  void initState() {
    // TODO: implement initState
    readAmenitiesJson();
    readHotelDetailsJson();
    super.initState();
  }

  Future<void> readAmenitiesJson() async {
    await rootBundle.loadString("assets/sample_amenities.json").then((value) {
      setState(() {
        amenitiesModel = AmenitiesModel.fromJson(json.decode(value));
      });
    });
  }

  Future<void> readHotelDetailsJson() async {
    await rootBundle.loadString("assets/hotel_description.json").then((value) {
      setState(() {
        final Map<String, dynamic> hotelDetailsMap = json.decode(value);
        hotelDetails = hotelDetailsMap.entries
            .toList()
            .map((entry) => MapEntry(entry.key, entry.value.toString()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.red.shade400,
            title: Text(
              widget.hotelDetailsModel.hotelName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/offerBanner.jpg"),
                            fit: BoxFit.cover),
                      ),
                    );
                  }),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 5,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.hotelDetailsModel.hotelName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Builder(builder: (BuildContext context) {
                              return IconButton(
                                  onPressed: () {
                                    showBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return HotelDetailsBottomWidget(
                                            hotelDetails: hotelDetails!,
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: Colors.blueAccent,
                                  ));
                            }),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "${widget.hotelDetailsModel.townName},",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.hotelDetailsModel.cityName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: InkWell(
                              onTap: () {},
                              child: const Text(
                                "Map View",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.97,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              padding: const EdgeInsets.all(10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.97,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AmenitiesFrameWidgetOne(
                          amenitiesModel: amenitiesModel,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.97,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AmenitiesFrameWidgetTwo(
                          amenitiesModel: amenitiesModel,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.97,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AmenitiesFrameWidgetThree(
                          amenitiesModel: amenitiesModel,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
