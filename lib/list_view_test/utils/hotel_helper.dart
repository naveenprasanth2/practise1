import '../models/star_ratings_model/star_ratings_average_model.dart';

class HotelHelper {
  static int calculateTotalRatings(RatingModel ratingModel) {
    return (ratingModel.oneStarRatingsCount +
            ratingModel.twoStarRatingsCount +
            ratingModel.threeStarRatingsCount +
            ratingModel.fourStarRatingsCount +
            ratingModel.fiveStarRatingsCount);
  }
}
