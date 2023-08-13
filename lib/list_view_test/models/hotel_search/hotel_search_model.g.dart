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
      price: json['price'] as int,
      averageRatings: (json['averageRatings'] as num).toDouble(),
      noOfRatings: json['noOfRatings'] as int,
      hotelId: json['hotelId'] as String,
    );

Map<String, dynamic> _$HotelSearchModelToJson(HotelSearchModel instance) =>
    <String, dynamic>{
      'hotelImages': instance.hotelImages,
      'hotelLocationDetails': instance.hotelLocationDetails,
      'highlights': instance.highlights,
      'price': instance.price,
      'averageRatings': instance.averageRatings,
      'noOfRatings': instance.noOfRatings,
      'hotelId': instance.hotelId,
    };
