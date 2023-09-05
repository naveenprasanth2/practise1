// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelSearchModel _$HotelSearchModelFromJson(Map<String, dynamic> json) =>
    HotelSearchModel(
      hotelImages: (json['hotelImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hotelLocationDetails: PlaceCategoryModel.fromJson(
          json['hotelLocationDetails'] as Map<String, dynamic>),
      highlights: (json['highlights'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hotelId: json['hotelId'] as String,
      roomTypeForSearch: (json['roomTypeForSearch'] as List<dynamic>)
          .map((e) => RoomTypeSearchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      starRatingAverageModel: StarRatingAverageModel.fromJson(
          json['ratings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HotelSearchModelToJson(HotelSearchModel instance) =>
    <String, dynamic>{
      'hotelImages': instance.hotelImages,
      'hotelLocationDetails': instance.hotelLocationDetails,
      'highlights': instance.highlights,
      'hotelId': instance.hotelId,
      'roomTypeForSearch': instance.roomTypeForSearch,
      'ratings': instance.starRatingAverageModel,
    };
