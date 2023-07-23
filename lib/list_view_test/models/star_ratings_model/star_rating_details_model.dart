import 'package:json_annotation/json_annotation.dart';

part 'star_rating_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StarRatingDetailsModel {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'rating')
  final int rating;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'timeStamp')
  final String timeStamp;

  @JsonKey(name: 'description')
  final String description;

  StarRatingDetailsModel({
    required this.name,
    required this.rating,
    required this.title,
    required this.timeStamp,
    required this.description,
  });

  factory StarRatingDetailsModel.fromJson(Map<String, dynamic> json) => _$StarRatingDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$StarRatingDetailsModelToJson(this);
}
