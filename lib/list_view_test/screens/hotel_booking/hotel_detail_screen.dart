import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/guest_policies/guest_policy_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:practise1/list_view_test/providers/calculation_provider.dart';
import 'package:practise1/list_view_test/screens/hotel_booking/images_detail_page.dart';
import 'package:practise1/list_view_test/widgets/booking/booking_widget.dart';
import 'package:practise1/list_view_test/widgets/hotel_details/pricing_detail_widget.dart';
import 'package:provider/provider.dart';
import 'package:practise1/list_view_test/models/amenities_model/amenities_model.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model.dart';
import 'package:practise1/list_view_test/models/star_ratings_model/star_ratings_average_model.dart';
import 'package:practise1/list_view_test/providers/count_provider.dart';
import 'package:practise1/list_view_test/providers/date_provider.dart';
import 'package:practise1/list_view_test/screens/guest_policies/guest_policies_screen.dart';
import 'package:practise1/list_view_test/utils/hotel_helper.dart';
import 'package:practise1/list_view_test/utils/star_rating_colour_utils.dart';
import 'package:practise1/list_view_test/widgets/adult_child/adult_child_bottom_sheet.dart';
import 'package:practise1/list_view_test/widgets/amenities/amenities_frame1.dart';
import 'package:practise1/list_view_test/widgets/amenities/amenities_frame2.dart';
import 'package:practise1/list_view_test/widgets/amenities/amenities_frame3.dart';
import 'package:practise1/list_view_test/widgets/hotel_details/guest_policies_widget.dart';
import 'package:practise1/list_view_test/widgets/hotel_details/hotel_details_bottom_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/hotel_detail_model/about_hotel_model.dart';
import '../reviews/reviews_screen.dart';
import 'images_categorization_page.dart';

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
  int? totalRatings;
  bool _isDataLoaded = false;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
      keepPage: true,
    );
    _pageController.addListener(() {
      setState(() {});
    });
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
        });
        // Update price data using Provider.of after data is loaded
        setPriceData();
      });
    }
  }

  Future<HotelDetailsModel?> readHotelDetailsModelJson() async {
    final value = await rootBundle.loadString("assets/hotel_details.json");
    setState(() {
      hotelDetailsModel = HotelDetailsModel.fromJson(json.decode(value));
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
    calculationProvider
        .setDiscountPercentage(hotelDetailsModel?.discountsApplicable[0] ?? 0);
    calculationProvider.setGstPercentage(12);
    calculationProvider.setDiscountPercentage(12);
    calculationProvider.setPrepaidDiscountPercentage(10);
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
                          Provider.of<DateProvider>(context, listen: true)
                                  .date ??
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (builder) => ImagesDetailPage(
                  //         hotelDetailsModel: hotelDetailsModel!),
                  //   ),
                  // );
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return HotelImagesBottomSheet(
                        hotelImagesModel: hotelDetailsModel!.hotelImages,
                      );
                    },
                  );
                },
                child: SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemCount:
                            hotelDetailsModel?.hotelImages.allImages.length ??
                                0,
                        physics: const RangeMaintainingScrollPhysics(),
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.network(
                              hotelDetailsModel!.hotelImages.allImages[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: hotelDetailsModel
                                    ?.hotelImages.allImages.length ??
                                0,
                            // Total number of dots (pages)
                            effect: const ScrollingDotsEffect(
                              dotColor: Colors.grey,
                              activeDotColor: Colors.white,
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 8,
                              maxVisibleDots: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (guestPolicies != null && guestPolicies!.length >= 3)
                      Column(
                        children: [
                          GuestPoliciesWidget(
                            guestPolicies: guestPolicies,
                            title: guestPolicies![0].title,
                            iconData: Icons.watch_later_outlined,
                          ),
                          GuestPoliciesWidget(
                            guestPolicies: guestPolicies,
                            title: guestPolicies![1].title,
                            iconData: Icons.account_box_outlined,
                          ),
                          GuestPoliciesWidget(
                            guestPolicies: guestPolicies,
                            title: guestPolicies![2].title,
                            iconData: Icons.favorite_outline_rounded,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
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
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
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
                    height: 80,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
