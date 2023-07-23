import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:practise1/list_view_test/models/hotel_search/hotel_search_model.dart';
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
      viewportFraction: 0.95,
      keepPage: true,
    );
    _pageController.addListener(() {
      setState(() {
      });
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
                physics: const ClampingScrollPhysics(),
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
                    count: widget.hotelSearchModel.hotelImages.length, // Total number of dots (pages)
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
      ],
    );
  }
}
