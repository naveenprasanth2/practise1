import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/amenities_model/amenities_model.dart';
import 'package:practise1/list_view_test/models/hotel_details_model.dart';
import 'package:practise1/list_view_test/widgets/amenities_frame.dart';

import '../../widgets/amenities_widget.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelDetailsModel hotelDetailsModel;

  const HotelDetailScreen({super.key, required this.hotelDetailsModel});

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  AmenitiesModel? amenitiesModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  void readJson() async {
    final String jsonString = await rootBundle.loadString('assets/sample.json');
    amenitiesModel = AmenitiesModel.fromJson(json.decode(jsonString));
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
                      child: Text(
                        widget.hotelDetailsModel.hotelName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
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
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: AmenitiesFrameWidget(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.97,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: AmenitiesFrameWidget(),
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
