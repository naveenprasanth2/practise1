import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/coupon_model/coupon_model.dart';
import 'package:practise1/list_view_test/models/guest_policies/guest_policy_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
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
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model.dart';
import 'package:practise1/list_view_test/models/star_ratings_model/star_ratings_average_model.dart';
import 'package:practise1/list_view_test/utils/hotel_helper.dart';
import 'package:practise1/list_view_test/utils/star_rating_colour_utils.dart';
import 'package:practise1/list_view_test/widgets/hotel_details/hotel_details_bottom_widget.dart';

import '../../models/hotel_detail_model/about_hotel_model.dart';
import '../../widgets/coupons/coupons_main_widget.dart';
import '../../widgets/hotel_details_main_widgets/guest_policies_widget.dart';
import '../../widgets/nearby_places/nearby_widget.dart';
import '../../widgets/room_occupancy_details/bookable_details_widget.dart';
import '../reviews/reviews_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final HotelSmallDetailsModel hotelSmallDetailsModel;

  const HotelDetailScreen({
    Key? key,
    required this.hotelSmallDetailsModel,
  }) : super(key: key);

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  AmenitiesModel? amenitiesModel;
  AboutHotelModel? aboutHotelModel;
  List<GuestPolicyModel>? guestPolicies;
  StarRatingAverageModel? hotelRatings;
  HotelDetailsModel? hotelDetailsModel;
  NearbyPlacesModel? nearbyPlacesModel;
  List<CouponModel>? coupons;
  int? totalRatings;
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
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
        });
        // Update price data using Provider.of after data is loaded
        setPriceData();
      });
    }
  }

  Future<HotelDetailsModel?> readHotelDetailsModelJson() async {
    final value = await rootBundle.loadString("assets/hotel_details.json");
    final couponList =
        await rootBundle.loadString("assets/discounts_applicable.json");
    setState(() {
      hotelDetailsModel = HotelDetailsModel.fromJson(json.decode(value));
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
    calculationProvider
        .setCostPerNight(hotelDetailsModel?.roomType.standardRoom.price ?? 0);
    calculationProvider.setDiscountPercentage(0);
    calculationProvider.setGstPercentage(12);
    calculationProvider.setPrepaidDiscountPercentage(10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          HotelImagesWithIconsWidget(hotelDetailsModel: hotelDetailsModel),
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
                            hotelDetailsModel?.hotelName ??
                                "Hotel Name Loading...",
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
                                      return aboutHotelModel != null
                                          ? HotelDetailsBottomWidget(
                                              aboutHotelModel: aboutHotelModel!,
                                            )
                                          : const SizedBox.shrink();
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
                              "${widget.hotelSmallDetailsModel.townName},",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.hotelSmallDetailsModel.cityName,
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
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) =>
                                            const MapScreen()));
                              },
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
                      child: hotelRatings != null
                          ? Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color:
                                      StarRatingColourUtils.getStarRatingColor(
                                          hotelRatings!.averageRating),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  hotelRatings!.averageRating.toString(),
                                  style: TextStyle(
                                    color: StarRatingColourUtils
                                        .getStarRatingColor(
                                            hotelRatings!.averageRating),
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
                                        builder: (context) => ReviewsScreen(
                                          averageRatings:
                                              hotelRatings!.averageRating,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "$totalRatings ratings",
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (amenitiesModel != null && hotelDetailsModel != null)
            AmenitiesMainWidget(
              amenitiesModel: amenitiesModel!,
              hotelDetailsModel: hotelDetailsModel!,
            ),
          GuestPoliciesMainWidget(
            guestPolicies: guestPolicies ?? [],
          ),
          CouponsMainWidget(
            coupons: coupons ?? [],
          ),
          const BookableDetailsWidget(),
          const CancellationPolicyWidget(),
          const HousePoliciesWidget(),
          if (nearbyPlacesModel != null)
            NearByTabView(
              nearbyPlacesModel: nearbyPlacesModel!,
            ),
        ],
      ),
      bottomNavigationBar: HotelDetailsBottomBar(
        hotelDetailsModel: hotelDetailsModel,
        aboutHotelModel: aboutHotelModel,
      ),
    );
  }
}
