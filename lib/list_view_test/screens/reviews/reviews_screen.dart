import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/hotel_search/hotel_search_model.dart';
import 'package:practise1/list_view_test/models/star_ratings_model/star_ratings_average_model.dart';
import 'package:practise1/list_view_test/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/list_view_test/widgets/ratings/ratings_widget.dart';

import '../../models/star_ratings_model/star_rating_details_model.dart';
import '../../utils/star_rating_colour_utils.dart';
import '../../widgets/ratings/ratings_tile.dart';

class ReviewsScreen extends StatefulWidget {
  final HotelSearchModel hotelSearchModel;
  final StarRatingAverageModel starRatingAverageModel;
  final String cityAndState;

  const ReviewsScreen(
      {Key? key,
      required this.starRatingAverageModel,
      required this.hotelSearchModel,
      required this.cityAndState})
      : super(key: key);

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<StarRatingDetailsModel> ratingsDetails = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getDetailedReviews();
  }

  Future<void> getDetailedReviews() async {
    final city = widget.cityAndState.split(",")[0].trim().toLowerCase();
    final state = widget.cityAndState.split(",")[1].trim().toLowerCase();

    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(state)
        .doc(city)
        .collection("hotels")
        .doc(widget.hotelSearchModel.hotelId)
        .collection("ratings")
        .get();

    List<StarRatingDetailsModel> tempList = [];
    for (var doc in querySnapshot.docs) {
      var docData =
          doc.data() as Map<String, dynamic>?; // Cast to Map<String, dynamic>
      if (docData != null) {
        var ratingsData = docData['ratings'] as Map<String, dynamic>;
        tempList.add(StarRatingDetailsModel.fromJson(ratingsData));
      }
    }
    setState(() {
      ratingsDetails = tempList;
      _isLoading = false;
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
            iconTheme: const IconThemeData(color: Colors.white),
            automaticallyImplyLeading: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
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
                                    color: StarRatingColourUtils
                                        .getStarRatingColor(widget
                                            .starRatingAverageModel
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
                                    widget
                                        .starRatingAverageModel.averageRating),
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
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: RatingStatsWidget(
                count5Stars: widget.starRatingAverageModel.fiveStarRatingsCount,
                count4Stars: widget.starRatingAverageModel.fourStarRatingsCount,
                count3Stars:
                    widget.starRatingAverageModel.threeStarRatingsCount,
                count2Stars: widget.starRatingAverageModel.twoStarRatingsCount,
                count1Star: widget.starRatingAverageModel.oneStarRatingsCount,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 20,
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black12,
                ),
              ],
            ),
          ),
          !_isLoading
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                height: 150,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: RatingsTile(
                                    ratingDetail: ratingsDetails[index]),
                              ),
                            ),
                          ),
                          const Divider(
                            thickness: 0.5,
                            color: Colors.black12,
                          ),
                        ],
                      );
                    },
                    childCount: ratingsDetails.length,
                  ),
                )
              : const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
