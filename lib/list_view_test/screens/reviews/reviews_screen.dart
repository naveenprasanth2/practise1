import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/widgets/ratings/ratings_widget.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade400,
        title: const Text(
          "Ratings & Reviews",
          style: (TextStyle(
            fontWeight: FontWeight.bold,
          )),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: const [
            RatingStatsWidget(
                count5Stars: 1,
                count4Stars: 4,
                count3Stars: 9,
                count2Stars: 7,
                count1Star: 5),
          ],
        ),
      ),
    );
  }
}
