import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_search/hotel_search_model.dart';
import 'package:practise1/list_view_test/models/room_type_search_model/room_type_search_model.dart';
import 'package:practise1/list_view_test/providers/count_provider.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/list_view_test/utils/price_helper/price_helper.dart';
import 'package:practise1/list_view_test/utils/star_rating_colour_utils.dart';
import 'package:practise1/list_view_test/widgets/hotel_results/highligths_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotelResultsWidget extends StatefulWidget {
  final HotelSearchModel hotelSearchModel;

  const HotelResultsWidget({super.key, required this.hotelSearchModel});

  @override
  State<HotelResultsWidget> createState() => _HotelResultsWidgetState();
}

class _HotelResultsWidgetState extends State<HotelResultsWidget> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CountProvider>(builder: (context, countProvider, _) {
      return Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                PageView.builder(
                  physics: const RangeMaintainingScrollPhysics(),
                  allowImplicitScrolling: true,
                  controller: _pageController,
                  itemCount: widget.hotelSearchModel.hotelImages.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Image.network(
                        widget.hotelSearchModel.hotelImages[index],
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
                      count: widget.hotelSearchModel.hotelImages.length,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: StarRatingColourUtils.getStarRatingColor(
                      widget.hotelSearchModel.averageRatings),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(widget.hotelSearchModel.averageRatings.toString()),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "(${widget.hotelSearchModel.noOfRatings})",
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hotelSearchModel.hotelLocationDetails.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.hotelSearchModel.highlights
                          .map(
                            (value) => HighLights(
                              value: value,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "₹${widget.hotelSearchModel.roomTypeForSearch[getRoomDetailsIndex()].discountedPrice}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBoxHelper.sizedBox_10,
                      Text(
                        "₹${widget.hotelSearchModel.roomTypeForSearch[getRoomDetailsIndex()].price}",
                        style: const TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.black),
                      ),
                      SizedBoxHelper.sizedBox_10,
                      Text(
                        "${PriceHelper.findPriceDiffInPercentage(widget.hotelSearchModel.roomTypeForSearch[getRoomDetailsIndex()].price.toDouble(), widget.hotelSearchModel.roomTypeForSearch[getRoomDetailsIndex()].discountedPrice.toDouble())}%",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  int getRoomDetailsIndex() {
    RoomTypeSearchModel? roomTypeSearchModel;
    roomTypeSearchModel = widget
        .hotelSearchModel.roomTypeForSearch
        .where((element) =>
            element.maxPeopleAllowed >=
            Provider.of<CountProvider>(context, listen: false)
                .maxAdultCountByCustomer).firstOrNull;
    if (roomTypeSearchModel != null) {
      return widget.hotelSearchModel.roomTypeForSearch
          .indexOf(roomTypeSearchModel);
    } else {
      return widget.hotelSearchModel.roomTypeForSearch
          .indexOf(widget.hotelSearchModel.roomTypeForSearch.last);
    }
  }
}
