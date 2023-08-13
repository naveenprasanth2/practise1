import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/coupon_model/coupon_model.dart';
import 'package:practise1/list_view_test/models/guest_policies/guest_policy_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/room_type_model.dart';
import 'package:practise1/list_view_test/models/hotel_search/hotel_search_model.dart';
import 'package:practise1/list_view_test/models/nearby_places_model/nearby_places_model.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/screens/maps/maps_screen.dart';
import 'package:practise1/list_view_test/widgets/cancellation/cancellation_policy.dart';
import 'package:practise1/list_view_test/widgets/hotel_details_main_widgets/amenities_main_widget.dart';
import 'package:practise1/list_view_test/widgets/hotel_details_main_widgets/hotel_images_widget.dart';
import 'package:practise1/list_view_test/widgets/hotel_details_main_widgets/pricing_details_widget.dart';
import 'package:practise1/list_view_test/widgets/house_policies/house_policies.dart';
import 'package:provider/provider.dart';
import 'package:practise1/list_view_test/models/amenities_model/amenities_model.dart';
import 'package:practise1/list_view_test/models/star_ratings_model/star_ratings_average_model.dart';
import 'package:practise1/list_view_test/utils/hotel_helper.dart';
import 'package:practise1/list_view_test/utils/star_rating_colour_utils.dart';
import 'package:practise1/list_view_test/widgets/hotel_details/hotel_details_bottom_widget.dart';

import '../../models/hotel_detail_model/about_hotel_model.dart';
import '../../widgets/coupons/coupons_main_widget.dart';
import '../../widgets/hotel_details_main_widgets/guest_policies_widget.dart';
import '../../widgets/nearby_places/nearby_widget.dart';
import '../../widgets/room_occupancy_details/bookable_details_widget.dart';
import '../../widgets/room_type/room_types_widget.dart';
import '../reviews/reviews_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelSearchModel hotelSearchModel;
  final String cityAndState;

  const HotelDetailScreen({
    Key? key,
    required this.hotelSearchModel,
    required this.cityAndState,
  }) : super(key: key);

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  Stream<HotelDetailsModel?>? _hotelDetailsStream;
  AmenitiesModel? amenitiesModel;
  AboutHotelModel? aboutHotelModel;
  List<GuestPolicyModel>? guestPolicies;
  StarRatingAverageModel? hotelRatings;
  HotelDetailsModel? hotelDetailsModel;
  NearbyPlacesModel? nearbyPlacesModel;
  List<CouponModel>? coupons;
  List<RoomTypeModel>? roomTypeModel;
  int? totalRatings;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _hotelDetailsStream = readHotelDetailsModelJson().asStream();
    readHotelRatingsJson();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataLoaded) {
      readHotelDetailsModelJson().then((hotelDetails) {
        setState(() {
          _isDataLoaded = true;
          hotelDetailsModel = hotelDetails;
          amenitiesModel = hotelDetailsModel!.amenities;
          guestPolicies = hotelDetailsModel!.guestPolicies;
          aboutHotelModel = hotelDetailsModel!.aboutHotelModel;
          nearbyPlacesModel = hotelDetailsModel!.locationDetails;
          roomTypeModel = hotelDetailsModel!.roomType;
        });
        // Update price data using Provider.of after data is loaded
        setPriceData();
      });
    }
  }

  Future<HotelDetailsModel?> readHotelDetailsModelJson() async {
    final valueFromDb = await FirebaseFirestore.instance
        .collection(widget.cityAndState.split(",")[1].trim().toLowerCase())
        .doc(widget.cityAndState.split(",")[0].trim().toLowerCase())
        .collection("hotels")
        .doc(widget.hotelSearchModel.hotelId)
        .collection("details")
        .doc(widget.hotelSearchModel.hotelId)
        .get();
    final couponList =
        await rootBundle.loadString("assets/discounts_applicable.json");
    setState(() {
      hotelDetailsModel =
          HotelDetailsModel.fromJson(valueFromDb.data()!["details"]);
      coupons = (json.decode(couponList) as List<dynamic>)
          .map((val) => CouponModel.fromJson(val))
          .toList();
      amenitiesModel = hotelDetailsModel!.amenities;
      guestPolicies = hotelDetailsModel!.guestPolicies;
      aboutHotelModel = hotelDetailsModel!.aboutHotelModel;
    });
    return hotelDetailsModel;
  }

  Future<void> readHotelRatingsJson() async {
    final value =
        await rootBundle.loadString("assets/star_ratings_average.json");
    setState(() {
      hotelRatings = StarRatingAverageModel.fromJson(json.decode(value));
      totalRatings = hotelRatings != null
          ? HotelHelper.calculateTotalRatings(hotelRatings!)
          : 0;
    });
  }

  setPriceData() {
    final calculationProvider =
        Provider.of<CalculationProvider>(context, listen: false);
    //need to change the price set value
    calculationProvider
        .setCostPerNight(hotelDetailsModel?.roomType[0].roomPrice ?? 0);
    calculationProvider.setDiscountPercentage(0);
    calculationProvider.setGstPercentage(12);
    calculationProvider.setPrepaidDiscountPercentage(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<HotelDetailsModel?>(
          stream: _hotelDetailsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Error loading hotel details"),
              );
            } else {
              final hotelDetailsModel = snapshot.data;
              if (hotelDetailsModel != null) {
                return Container(
                  color: Colors.white,
                  child: CustomScrollView(
                    physics: const PageScrollPhysics(),
                    slivers: [
                      HotelImagesWithIconsWidget(
                          hotelDetailsModel: hotelDetailsModel),
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.hotelSearchModel.hotelLocationDetails.name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Center(
                                      child: Builder(
                                        builder: (BuildContext context) {
                                          return IconButton(
                                            onPressed: () {
                                              showBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return aboutHotelModel !=
                                                            null
                                                        ? HotelDetailsBottomWidget(
                                                            aboutHotelModel:
                                                                aboutHotelModel!,
                                                          )
                                                        : const SizedBox
                                                            .shrink();
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.info_outline,
                                              color: Colors.red.shade400,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${hotelDetailsModel?.locationDetails.hotelLocationDetails.address},",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: StarRatingColourUtils
                                              .getStarRatingColor(widget
                                                  .hotelSearchModel
                                                  .averageRatings),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.hotelSearchModel.averageRatings
                                              .toString(),
                                          style: TextStyle(
                                            color: StarRatingColourUtils
                                                .getStarRatingColor(widget
                                                    .hotelSearchModel
                                                    .averageRatings),
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
                                                builder: (context) =>
                                                    ReviewsScreen(
                                                  averageRatings: widget
                                                      .hotelSearchModel
                                                      .averageRatings,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "${widget.hotelSearchModel.noOfRatings} ratings",
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    const MapScreen()));
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Map View",
                                            style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (amenitiesModel != null)
                        AmenitiesMainWidget(
                          amenitiesModel: amenitiesModel!,
                          hotelDetailsModel: hotelDetailsModel,
                        ),
                      GuestPoliciesMainWidget(
                        guestPolicies: guestPolicies ?? [],
                      ),
                      CouponsMainWidget(
                        coupons: coupons ?? [],
                      ),
                      const BookableDetailsWidget(),
                      RoomTypesWidget(
                        roomTypeModel: roomTypeModel ?? [],
                      ),
                      const CancellationPolicyWidget(),
                      const HousePoliciesWidget(),
                      if (nearbyPlacesModel != null)
                        NearByTabView(
                          nearbyPlacesModel: nearbyPlacesModel!,
                        ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("No hotel details available"),
                );
              }
            }
          }),
      bottomNavigationBar: HotelDetailsBottomBar(
        hotelDetailsModel: hotelDetailsModel,
        aboutHotelModel: aboutHotelModel,
      ),
    );
  }
}
