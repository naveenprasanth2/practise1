// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'star_rating_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StarRatingDetailsModel _$StarRatingDetailsModelFromJson(
        Map<String, dynamic> json) =>
    StarRatingDetailsModel(
      name: json['name'] as String,
      rating: json['rating'] as int,
      title: json['title'] as String,
      timeStamp: json['timeStamp'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$StarRatingDetailsModelToJson(
        StarRatingDetailsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
      'title': instance.title,
      'timeStamp': instance.timeStamp,
      'description': instance.description,
    };
