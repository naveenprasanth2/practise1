import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/widgets/ratings/ratings_widget.dart';

import '../../utils/star_rating_colour_utils.dart';

class ReviewsScreen extends StatefulWidget {
  final double averageRatings;

  const ReviewsScreen({Key? key, required this.averageRatings})
      : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Map<String, dynamic>> ratingsDetails = [];

  @override
  void initState() {
    super.initState();
    getDetailedRatingsFromJson();
  }

  Future<void> getDetailedRatingsFromJson() async {
    final value =
        await rootBundle.loadString("assets/star_ratings_detail.json");
    setState(() {
      final dynamic ratingsDetailsData = json.decode(value);

      for (var json in ratingsDetailsData) {
        ratingsDetails.add(json);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.red.shade400,
            title: const Text(
              "Ratings & Reviews",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red.shade100),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color:
                                      StarRatingColourUtils.getStarRatingColor(
                                          widget.averageRatings),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.averageRatings.toString(),
                                  style: TextStyle(
                                    color: StarRatingColourUtils
                                        .getStarRatingColor(
                                            widget.averageRatings),
                                  ),
                                ),
                              ],
                            ),
                            const Text("out of 5"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good",
                          style: TextStyle(
                            color: StarRatingColourUtils.getStarRatingColor(
                                widget.averageRatings),
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text("${ratingsDetails.length} Ratings"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: RatingStatsWidget(
              count5Stars: 1,
              count4Stars: 4,
              count3Stars: 9,
              count2Stars: 7,
              count1Star: 5,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                  ),
                );
              },
              childCount: ratingsDetails.length,
            ),
          ),
        ],
      ),
    );
  }
}
