import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/booking_history_model/booking_history_display_model.dart';
import 'package:practise1/list_view_test/models/booking_history_model/booking_history_model.dart';
import 'package:practise1/list_view_test/models/star_ratings_model/star_rating_details_model.dart';
import 'package:practise1/list_view_test/providers/profile_provider.dart';
import 'package:practise1/list_view_test/utils/date_helper/date_helper.dart';
import 'package:practise1/list_view_test/utils/ratings_helper/ratings_helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../utils/dart_helper/sizebox_helper.dart';

class RatingView extends StatefulWidget {
  final BookingHistoryDisplayModel bookingHistoryDisplayModel;
  const RatingView({
    super.key,
    required this.bookingHistoryDisplayModel,
  });

  @override
  State<RatingView> createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  final PageController _pageController = PageController();
  double _starPosition = 250.0;
  int _rating = 0;
  String _selectedValue = "General";
  bool _isMoreDetailActive = false;
  final FocusNode _moreDetailsFocusNode = FocusNode();
  List<String> feedbackOptions = [
    "Bedroom",
    "Washroom",
    "Bed",
    "Staff Behaviour",
    "Cleanliness",
    "Basic Amenities",
  ];

  int? noOfStarsSelected;
  String? whatCouldBeBetter;
  String? description;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Thanks Note and Cause of Rating
          SizedBox(
            height: max(350, MediaQuery.of(context).size.height * 0.35),
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildThanksNote(),
                _causeOfRating(),
              ],
            ),
          ),
          // Submit button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.red.shade400,
              child: MaterialButton(
                onPressed: () {
                  sendFeedback();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          // Skip button
          Positioned(
            right: 0,
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("skip"),
            ),
          ),
          SizedBoxHelper.sizedBox10,
          // Animated stars
          AnimatedPositioned(
            top: _starPosition,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                    setState(() {
                      _starPosition = 30.0;
                      //index starts with 0, so added 1
                      _rating = index + 1;
                      noOfStarsSelected = _rating;
                    });
                  },
                  icon: index < _rating
                      ? const Icon(Icons.star)
                      : const Icon(Icons.star_outline_outlined),
                  color: Colors.red.shade400,
                ),
              ),
            ),
          ),
          // Back button
          if (_isMoreDetailActive)
            Positioned(
              top: 0,
              left: 0,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    _isMoreDetailActive = false;
                  });
                },
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildThanksNote() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Thanks for using our service",
          style: TextStyle(
            fontSize: 24,
            color: Colors.red.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBoxHelper.sizedBox30,
        const Text("We'd love to hear your feedback"),
        const Text("How was your experience?"),
        SizedBoxHelper.sizedBox50,
      ],
    );
  }

  Widget _causeOfRating() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: !_isMoreDetailActive,
          // Text field display
          replacement: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tell us more"),
              Chip(
                label: Text(_selectedValue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textEditingController,
                  focusNode: _moreDetailsFocusNode,
                  decoration: InputDecoration(
                    hintText: "Write your review here",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("What could be better?"),
              Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  for (String option in feedbackOptions)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedValue = option;
                          whatCouldBeBetter = _selectedValue;
                        });
                      },
                      child: Chip(
                        backgroundColor: _selectedValue == option
                            ? Colors.red.shade400
                            : Colors.grey.shade200,
                        label: Text(
                          option,
                          style: TextStyle(
                            color: _selectedValue == option
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _moreDetailsFocusNode.requestFocus();
                    _isMoreDetailActive = true;
                  });
                },
                child: const Text(
                  "want to tell us more?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void sendFeedback() async {
    final BookingHistoryModel bookingHistoryModel =
        widget.bookingHistoryDisplayModel.bookingHistoryModel;
    final ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    description = _textEditingController.text == ""
        ? RatingsHelper.titleBasedOnStars(noOfStarsSelected!)
        : _textEditingController.text;
    StarRatingDetailsModel starRatingDetailsModel = StarRatingDetailsModel(
        name: profileProvider.name!,
        rating: noOfStarsSelected!,
        title: RatingsHelper.titleBasedOnStars(noOfStarsSelected!),
        timeStamp: DateHelper.getCurrentDate(),
        description: description!);

    final response = await http.post(
      Uri.parse("https://us-central1-bookany.cloudfunctions.net/processRating"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'bookingHistoryModel': bookingHistoryModel,
        'starRatingDetailsModel': starRatingDetailsModel,
        'mobileNo':
            Provider.of<ProfileProvider>(context, listen: false).mobileNo,
      }),
    );

    if (response.statusCode == 200) {
      print('Successfully sent rating!');
    } else {
      print('Failed to send rating: ${response.body}');
    }
  }
}
