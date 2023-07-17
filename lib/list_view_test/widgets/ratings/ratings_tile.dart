import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../models/star_ratings_model/star_rating_details_model.dart';
import '../../utils/star_rating_colour_utils.dart';

class RatingsTile extends StatelessWidget {
  final StarRatingDetailsModel ratingDetail;

  const RatingsTile({super.key, required this.ratingDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      ratingDetail.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black26),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified,
                          color: Colors.green.shade500,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        const Text(
                          "Verified Stay",
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(ratingDetail.description),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ratingDetail.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RatingBarIndicator(
                      rating: double.parse(ratingDetail.rating.toString()),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: StarRatingColourUtils.getStarRatingColor(
                            double.parse(ratingDetail.rating.toString())),
                      ),
                      itemCount: 5,
                      itemSize: 20.0,
                      unratedColor: Colors.grey,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      ratingDetail.timeStamp,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
