import 'package:json_annotation/json_annotation.dart';
part 'star_ratings_average_model.g.dart';


@JsonSerializable()
class RatingModel {
  @JsonKey(name: 'averageRating')
  final double averageRating;

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

  RatingModel({
    required this.averageRating,
    required this.oneStarRatingsCount,
    required this.twoStarRatingsCount,
    required this.threeStarRatingsCount,
    required this.fourStarRatingsCount,
    required this.fiveStarRatingsCount,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);
}
