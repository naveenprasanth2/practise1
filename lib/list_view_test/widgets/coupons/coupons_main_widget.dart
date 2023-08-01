import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/widgets/coupons/coupon_display_container_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CouponsMainWidget extends StatefulWidget {
  const CouponsMainWidget({
    super.key,
  });

  @override
  State<CouponsMainWidget> createState() => _CouponsMainWidgetState();
}

class _CouponsMainWidgetState extends State<CouponsMainWidget> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
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
    return SliverToBoxAdapter(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Offers to look into",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 80,
                  child: PageView.builder(
                    itemCount: 10,
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    padEnds: false,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CouponDisplayContainerWidget(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 10,
                effect: ScrollingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.red.shade400,
                  dotHeight: 5,
                  dotWidth: 5,
                  spacing: 5,
                  maxVisibleDots: 5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Builder(builder: (context) {
              return InkWell(
                onTap: () {
                  // showBottomSheet(
                  //   context: context,
                  //   builder: (context) {
                  //     return AmenitiesBottomWidget(
                  //       hotelDetailsModel: hotelDetailsModel,
                  //     );
                  //   },
                  // );
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red.shade400,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
