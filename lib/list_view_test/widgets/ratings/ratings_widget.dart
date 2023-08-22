import 'package:flutter/material.dart';

import '../../utils/dart_helper/sizebox_helper.dart';
import '../../utils/star_rating_colour_utils.dart';

class RatingStatsWidget extends StatelessWidget {
  final int count5Stars;
  final int count4Stars;
  final int count3Stars;
  final int count2Stars;
  final int count1Star;

  const RatingStatsWidget({
    super.key,
    required this.count5Stars,
    required this.count4Stars,
    required this.count3Stars,
    required this.count2Stars,
    required this.count1Star,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          _buildRatingStatRow(
            5,
            "Excellent",
            count5Stars,
            StarRatingColourUtils.getStarRatingColor(5),
          ),
          _buildRatingStatRow(
            4,
            "Very Good",
            count4Stars,
            StarRatingColourUtils.getStarRatingColor(4),
          ),
          _buildRatingStatRow(
            3,
            "Good",
            count3Stars,
            StarRatingColourUtils.getStarRatingColor(3),
          ),
          _buildRatingStatRow(
            2,
            "Poor",
            count2Stars,
            StarRatingColourUtils.getStarRatingColor(2),
          ),
          _buildRatingStatRow(
            1,
            "Very Poor",
            count1Star,
            StarRatingColourUtils.getStarRatingColor(1),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStatRow(int rating, String value, int count, Color color) {
    final double barWidth = (count.toDouble() / _getTotalCount()) *
        200; // Adjust the bar width as per your requirement

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 130,
            child: Row(
              children: [
                Text(
                  '$rating ',
                ),
                Icon(
                  Icons.star,
                  color: color,
                ),
                SizedBoxHelper.sizedBox_4,
                Text(
                  '($value)',
                ),
              ],
            ),
          ),
          SizedBox(
            width: 180,
            // Adjust the width to control the spacing between text and bars
            child: Stack(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  height: 10,
                  width: barWidth,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
          ),
          SizedBoxHelper.sizedBox_5,
          Text('$count'),
        ],
      ),
    );
  }

  int _getTotalCount() {
    return count5Stars + count4Stars + count3Stars + count2Stars + count1Star;
  }
}
