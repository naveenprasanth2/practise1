import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_search/hotel_search_model.dart';
import 'package:practise1/list_view_test/utils/star_rating_colour_utils.dart';
import 'package:practise1/list_view_test/widgets/hotel_results/highligths_widget.dart';
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
                "${widget.hotelSearchModel.noOfRatings} Reviews",
                style: TextStyle(
                  color: Colors.grey.shade600),
                ),
            ],
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
                  widget.hotelSearchModel.hotelName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "₹ ${widget.hotelSearchModel.price.toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Text(
                  "inclusive of all taxes",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
