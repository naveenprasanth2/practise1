// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_hotel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutHotelModel _$AboutHotelModelFromJson(Map<String, dynamic> json) =>
    AboutHotelModel(
      description: json['Description'] as String,
      specialFeatures: json['Special Features'] as String,
      locationAndTransportation: json['Location & Transportation'] as String,
    );

Map<String, dynamic> _$AboutHotelModelToJson(AboutHotelModel instance) =>
    <String, dynamic>{
      'Description': instance.description,
      'Special Features': instance.specialFeatures,
      'Location & Transportation': instance.locationAndTransportation,
    };
