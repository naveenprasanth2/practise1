// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationsModel _$LocationsModelFromJson(Map<String, dynamic> json) =>
    LocationsModel(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationsModelToJson(LocationsModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
