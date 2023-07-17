// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'star_ratings_average_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      averageRating: (json['averageRating'] as num).toDouble(),
      oneStarRatingsCount: json['oneStarRatingsCount'] as int,
      twoStarRatingsCount: json['twoStarRatingsCount'] as int,
      threeStarRatingsCount: json['threeStarRatingsCount'] as int,
      fourStarRatingsCount: json['fourStarRatingsCount'] as int,
      fiveStarRatingsCount: json['fiveStarRatingsCount'] as int,
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'averageRating': instance.averageRating,
      'oneStarRatingsCount': instance.oneStarRatingsCount,
      'twoStarRatingsCount': instance.twoStarRatingsCount,
      'threeStarRatingsCount': instance.threeStarRatingsCount,
      'fourStarRatingsCount': instance.fourStarRatingsCount,
      'fiveStarRatingsCount': instance.fiveStarRatingsCount,
    };
