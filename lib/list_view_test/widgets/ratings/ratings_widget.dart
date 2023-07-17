import 'package:flutter/material.dart';

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
            Colors.green.shade800,
          ),
          _buildRatingStatRow(
            4,
            "Very Good",
            count4Stars,
            Colors.green.shade400,
          ),
          _buildRatingStatRow(
            3,
            "Good",
            count3Stars,
            Colors.yellow.shade400,
          ),
          _buildRatingStatRow(
            2,
            "Poor",
            count2Stars,
            Colors.orange.shade400,
          ),
          _buildRatingStatRow(
            1,
            "Very Poor",
            count1Star,
            Colors.red.shade500,
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
                const SizedBox(width: 4),
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
          const SizedBox(width: 5),
          Text('$count'),
        ],
      ),
    );
  }

  int _getTotalCount() {
    return count5Stars + count4Stars + count3Stars + count2Stars + count1Star;
  }
}
