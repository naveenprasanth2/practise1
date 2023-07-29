import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/widgets/ratings/rating_view.dart';

class RatingDialogHelper{
  static void openRatingDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return const Dialog(
        child: RatingView(),
      );
    });
  }
}