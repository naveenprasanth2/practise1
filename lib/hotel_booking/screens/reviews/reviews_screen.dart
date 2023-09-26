import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/hotel_search/hotel_search_model.dart';
import 'package:practise1/hotel_booking/models/star_ratings_model/star_ratings_average_model.dart';
import 'package:practise1/hotel_booking/utils/dart_helper/sizebox_helper.dart';
import 'package:practise1/hotel_booking/widgets/ratings/ratings_widget.dart';

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
  DocumentSnapshot? lastDocument;
  bool _isFetchingMore = false;
  // Change this to however many you want per fetch
  final int documentsPerPage = 20;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getDetailedReviews();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreReviews();
      }
    });
  }

  Future<void> getDetailedReviews() async {
    final city = widget.cityAndState.split(",")[0].trim().toLowerCase();
    final state = widget.cityAndState.split(",")[1].trim().toLowerCase();

    // Get the first batch of documents
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(state)
        .doc(city)
        .collection("hotels")
        .doc(widget.hotelSearchModel.hotelId)
        .collection("ratings")
        .orderBy('ratings.timeStamp',
            descending: true) // Sort based on nested field
        .limit(documentsPerPage)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs.last;
    }

    List<StarRatingDetailsModel> tempList = [];
    for (var doc in querySnapshot.docs) {
      var docData = doc.data() as Map<String, dynamic>?;
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

  Future<void> loadMoreReviews() async {
    setState(() {
      _isFetchingMore = true;
    });
    if (lastDocument == null) return;

    final city = widget.cityAndState.split(",")[0].trim().toLowerCase();
    final state = widget.cityAndState.split(",")[1].trim().toLowerCase();

    // Get the next batch of documents starting after the last one
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(state)
        .doc(city)
        .collection("hotels")
        .doc(widget.hotelSearchModel.hotelId)
        .collection("ratings")
        .orderBy('ratings.timeStamp',
            descending: true) // Sort based on nested field
        .startAfterDocument(lastDocument!)
        .limit(documentsPerPage)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs.last;
    }

    List<StarRatingDetailsModel> tempList = [];
    for (var doc in querySnapshot.docs) {
      var docData = doc.data() as Map<String, dynamic>?;
      if (docData != null) {
        var ratingsData = docData['ratings'] as Map<String, dynamic>;
        tempList.add(StarRatingDetailsModel.fromJson(ratingsData));
      }
    }

    setState(() {
      ratingsDetails.addAll(
          tempList); // Here, you append to your list instead of replacing it
      _isFetchingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
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
          if (_isFetchingMore)
            const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: Colors.red),
                ),
              ),
            )
          else
            const SliverToBoxAdapter(
                child: SizedBox
                    .shrink()), // This is an empty box to maintain the structure when not loading more data.
        ],
      ),
    );
  }
}
