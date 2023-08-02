import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/widgets/coupons/coupon_display_container_widget.dart';
import 'package:practise1/list_view_test/widgets/coupons/coupon_widget_with_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../models/coupon_model/coupon_model.dart';

class CouponsMainWidget extends StatefulWidget {
  final List<CouponModel> coupons;

  const CouponsMainWidget({
    super.key,
    required this.coupons,
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
      viewportFraction: 0.85,
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
            height: 150,
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
                  height: 100,
                  child: PageView.builder(
                    itemCount: widget.coupons.length,
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    padEnds: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: CouponDisplayContainerWidget(
                              couponModel: widget.coupons[index],
                            ),
                          ),
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
                count: widget.coupons.length,
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
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // Make the Column take the minimum height needed
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.close),
                                ),
                              ],
                            ),
                            Expanded(
                              // Add Expanded here to make ListView take available space
                              child: ListView.builder(
                                itemCount: widget.coupons.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CouponWidgetWithButton(
                                      couponModel: widget.coupons[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  "View all offers",
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
