import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/amenities_model/amenities_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model.dart';
import 'package:practise1/list_view_test/screens/guest_policies/guest_policies_screen.dart';
import 'package:practise1/list_view_test/widgets/amenities/amenities_frame1.dart';
import 'package:practise1/list_view_test/widgets/amenities/amenities_frame2.dart';
import 'package:practise1/list_view_test/widgets/hotel_details/guest_policies_widget.dart';
import 'package:practise1/list_view_test/widgets/hotel_details/hotel_details.dart';
import 'package:provider/provider.dart';

import '../../providers/count_provider.dart';
import '../../providers/date_provider.dart';
import '../../widgets/adult_child/adult_child_bottom_sheet.dart';
import '../../widgets/amenities/amenities_frame3.dart';
import '../../widgets/bottom_bar/bottom_bar_delegate.dart';
import '../reviews/reviews_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelDetailsModel hotelDetailsModel;

  const HotelDetailScreen({Key? key, required this.hotelDetailsModel})
      : super(key: key);

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  AmenitiesModel? amenitiesModel;
  List<MapEntry<String, dynamic>>? hotelDetails;
  List<MapEntry<String, dynamic>>? guestPolicies;

  @override
  void initState() {
    super.initState();
    readAmenitiesJson();
    readHotelDetailsJson();
    guestPoliciesJson();
  }

  Future<void> readAmenitiesJson() async {
    final value = await rootBundle.loadString("assets/sample_amenities.json");
    setState(() {
      amenitiesModel = AmenitiesModel.fromJson(json.decode(value));
    });
  }

  Future<void> readHotelDetailsJson() async {
    final value = await rootBundle.loadString("assets/hotel_description.json");
    setState(() {
      final Map<String, dynamic> hotelDetailsMap = json.decode(value);
      hotelDetails = hotelDetailsMap.entries
          .toList()
          .map((entry) => MapEntry(entry.key, entry.value.toString()))
          .toList();
    });
  }

  Future<void> guestPoliciesJson() async {
    final value = await rootBundle.loadString("assets/guest_policies.json");
    setState(() {
      final dynamic guestPoliciesData = json.decode(value);

      if (guestPoliciesData is List) {
        guestPolicies = guestPoliciesData
            .map((map) => MapEntry(map['title']?.toString() ?? '',
                map['description']?.toString() ?? ''))
            .toList();
      }
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
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
            ],
            backgroundColor: Colors.red.shade400,
            title: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.hotelDetailsModel.hotelName,
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
                              fontSize: 15, color: Colors.white),
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
                          Provider.of<DateProvider>(context, listen: true)
                                  .date ??
                              Provider.of<DateProvider>(context, listen: true)
                                  .initialDate!,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
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
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.red.shade400,
                                ),
                              );
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
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.hotelDetailsModel.cityName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: InkWell(
                              onTap: () {},
                              child: const Text(
                                "Map View",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                        child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.green.shade500,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "4.5",
                          style: TextStyle(
                            color: Colors.green.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (e) => const ReviewsScreen()));
                            },
                            child: const Text("33 ratings")),
                      ],
                    )),
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
          //guest policies builder
          //we use only first 3 widgets to display things
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Guest Policies",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => GuestPoliciesScreen(
                                          guestPolicies: guestPolicies,
                                        )));
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                                fontSize: 15, color: Colors.red.shade400),
                          ),
                        ),
                      ],
                    ),
                    GuestPoliciesWidget(
                      guestPolicies: guestPolicies,
                      title: "Check-in and Check-out",
                      iconData: Icons.watch_later_outlined,
                    ),
                    GuestPoliciesWidget(
                      guestPolicies: guestPolicies,
                      title: "Local ID Policy",
                      iconData: Icons.account_box_outlined,
                    ),
                    GuestPoliciesWidget(
                      guestPolicies: guestPolicies,
                      title: "Couple Friendly",
                      iconData: Icons.favorite_outline_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
