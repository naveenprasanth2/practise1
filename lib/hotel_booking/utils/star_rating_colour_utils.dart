import 'package:flutter/material.dart';

class StarRatingColourUtils {
  static Color getStarRatingColor(double rating) {
    if (rating >= 4.5) {
      return Colors.green.shade800;
    } else if (rating >= 3.5) {
      return Colors.green.shade400;
    } else if (rating >= 2.5) {
      return Colors.orange.shade400;
    } else if (rating >= 1.5) {
      return Colors.yellow.shade400;
    } else {
      return Colors.red.shade400;
    }
  }
}
