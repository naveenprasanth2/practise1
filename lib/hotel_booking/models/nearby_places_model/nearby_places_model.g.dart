// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nearby_places_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NearbyPlacesModel _$NearbyPlacesModelFromJson(Map<String, dynamic> json) =>
    NearbyPlacesModel(
      hotelLocationDetails: PlaceCategoryModel.fromJson(
          json['hotelLocationDetails'] as Map<String, dynamic>),
      transport: (json['transport'] as List<dynamic>)
          .map((e) => PlaceCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mallsAndRestaurants: (json['mallsAndRestaurants'] as List<dynamic>)
          .map((e) => PlaceCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      popularPlaces: (json['popularPlaces'] as List<dynamic>)
          .map((e) => PlaceCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      others: (json['others'] as List<dynamic>)
          .map((e) => PlaceCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NearbyPlacesModelToJson(NearbyPlacesModel instance) =>
    <String, dynamic>{
      'hotelLocationDetails': instance.hotelLocationDetails,
      'transport': instance.transport,
      'mallsAndRestaurants': instance.mallsAndRestaurants,
      'popularPlaces': instance.popularPlaces,
      'others': instance.others,
    };
