import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/hotel_details_model_v2.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImagesDetailPage extends StatefulWidget {
  final HotelDetailsModel hotelDetailsModel;

  const ImagesDetailPage({super.key, required this.hotelDetailsModel});

  @override
  State<ImagesDetailPage> createState() => _ImagesDetailPageState();
}

class _ImagesDetailPageState extends State<ImagesDetailPage> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
      keepPage: true,
    );
    _pageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Center(
            child: SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount:
                    widget.hotelDetailsModel.hotelImages.allImages.length,
                physics: const RangeMaintainingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Image.network(
                      widget.hotelDetailsModel.hotelImages.allImages[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: widget.hotelDetailsModel.hotelImages.allImages.length,
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
    );
  }
}
