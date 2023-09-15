// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'star_ratings_average_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StarRatingAverageModel _$StarRatingAverageModelFromJson(
        Map<String, dynamic> json) =>
    StarRatingAverageModel(
      averageRating: (json['averageRating'] as num).toDouble(),
      noOfRatings: json['noOfRatings'] as int,
      oneStarRatingsCount: json['oneStarRatingsCount'] as int,
      twoStarRatingsCount: json['twoStarRatingsCount'] as int,
      threeStarRatingsCount: json['threeStarRatingsCount'] as int,
      fourStarRatingsCount: json['fourStarRatingsCount'] as int,
      fiveStarRatingsCount: json['fiveStarRatingsCount'] as int,
    );

Map<String, dynamic> _$StarRatingAverageModelToJson(
        StarRatingAverageModel instance) =>
    <String, dynamic>{
      'averageRating': instance.averageRating,
      'noOfRatings': instance.noOfRatings,
      'oneStarRatingsCount': instance.oneStarRatingsCount,
      'twoStarRatingsCount': instance.twoStarRatingsCount,
      'threeStarRatingsCount': instance.threeStarRatingsCount,
      'fourStarRatingsCount': instance.fourStarRatingsCount,
      'fiveStarRatingsCount': instance.fiveStarRatingsCount,
    };
