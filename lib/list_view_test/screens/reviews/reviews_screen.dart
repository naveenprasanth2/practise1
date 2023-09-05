import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practise1/list_view_test/models/star_ratings_model/star_ratings_average_model.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/list_view_test/widgets/ratings/ratings_widget.dart';

import '../../models/star_ratings_model/star_rating_details_model.dart';
import '../../utils/star_rating_colour_utils.dart';
import '../../widgets/ratings/ratings_tile.dart';

class ReviewsScreen extends StatefulWidget {
  final StarRatingAverageModel starRatingAverageModel;

  const ReviewsScreen({Key? key, required this.starRatingAverageModel})
      : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<StarRatingDetailsModel> ratingsDetails = [];

  @override
  void initState() {
    super.initState();
    getDetailedReviewsFromJson();
  }

  Future<void> getDetailedReviewsFromJson() async {
    final value =
        await rootBundle.loadString("assets/star_ratings_detail.json");
    setState(() {
      final dynamic ratingsDetailsData = json.decode(value);

      for (var json in ratingsDetailsData) {
        ratingsDetails.add(StarRatingDetailsModel.fromJson(json));
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
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                        border: Border.all(
                          color: StarRatingColourUtils.getStarRatingColor(
                              widget.starRatingAverageModel.averageRating),
                        ),
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
                                          widget.starRatingAverageModel
                                              .averageRating),
                                ),
                                SizedBoxHelper.sizedBox_6,
                                Text(
                                  widget.starRatingAverageModel.averageRating
                                      .toStringAsFixed(1),
                                  style: TextStyle(
                                    color: StarRatingColourUtils
                                        .getStarRatingColor(widget
                                            .starRatingAverageModel
                                            .averageRating),
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
                                  widget.starRatingAverageModel.averageRating),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "${widget.starRatingAverageModel.noOfRatings} Ratings"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: RatingStatsWidget(
              count5Stars: widget.starRatingAverageModel.fiveStarRatingsCount,
              count4Stars: widget.starRatingAverageModel.fourStarRatingsCount,
              count3Stars: widget.starRatingAverageModel.threeStarRatingsCount,
              count2Stars: widget.starRatingAverageModel.twoStarRatingsCount,
              count1Star: widget.starRatingAverageModel.oneStarRatingsCount,
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
                    height: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black26)),
                    child: RatingsTile(ratingDetail: ratingsDetails[index]),
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
