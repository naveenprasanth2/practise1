// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceCategoryModel _$PlaceCategoryModelFromJson(Map<String, dynamic> json) =>
    PlaceCategoryModel(
      name: json['name'] as String,
      address: json['address'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$PlaceCategoryModelToJson(PlaceCategoryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };
