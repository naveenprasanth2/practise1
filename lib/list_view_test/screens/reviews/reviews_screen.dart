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
          children: [
            Row(
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
                    child: const Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star),
                              SizedBox(width: 6),
                              Text("4.5"),
                            ],
                          ),
                          Text("out of 5"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Good"),
                      Text("53 Ratings"),
                    ],
                  ),
                ),
              ],
            ),
            const RatingStatsWidget(
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
