import 'package:json_annotation/json_annotation.dart';

part 'star_ratings_average_model.g.dart';

@JsonSerializable()
class StarRatingAverageModel {
  @JsonKey(name: 'averageRating')
  final double averageRating;

  @JsonKey(name: 'noOfRatings')
  final int noOfRatings;

  @JsonKey(name: 'oneStarRatingsCount')
  final int oneStarRatingsCount;

  @JsonKey(name: 'twoStarRatingsCount')
  final int twoStarRatingsCount;

  @JsonKey(name: 'threeStarRatingsCount')
  final int threeStarRatingsCount;

  @JsonKey(name: 'fourStarRatingsCount')
  final int fourStarRatingsCount;

  @JsonKey(name: 'fiveStarRatingsCount')
  final int fiveStarRatingsCount;

  StarRatingAverageModel({
    required this.averageRating,
    required this.noOfRatings,
    required this.oneStarRatingsCount,
    required this.twoStarRatingsCount,
    required this.threeStarRatingsCount,
    required this.fourStarRatingsCount,
    required this.fiveStarRatingsCount,
  });

  factory StarRatingAverageModel.fromJson(Map<String, dynamic> json) =>
      _$StarRatingAverageModelFromJson(json);

  Map<String, dynamic> toJson() => _$StarRatingAverageModelToJson(this);
}
