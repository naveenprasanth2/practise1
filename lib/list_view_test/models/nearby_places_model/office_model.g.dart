// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficeModel _$OfficeModelFromJson(Map<String, dynamic> json) => OfficeModel(
      json['name'] as String,
      json['address'] as String,
      (json['lat'] as num).toDouble(),
      (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$OfficeModelToJson(OfficeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
    };
