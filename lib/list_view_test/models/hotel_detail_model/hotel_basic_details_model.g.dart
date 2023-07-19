// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_basic_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelBasicDetailsModel _$HotelBasicDetailsModelFromJson(
        Map<String, dynamic> json) =>
    HotelBasicDetailsModel(
      hotelName: json['hotelName'] as String,
      doorNumber: json['doorNumber'] as String,
      streetNumber: json['streetNumber'] as String,
      cityName: json['cityName'] as String,
      id: json['id'] as String,
      mainImage: json['mainImage'] as String,
      locationsModel:
          LocationsModel.fromJson(json['locations'] as Map<String, dynamic>),
      highlights: (json['highlights'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      discountsApplicable: (json['discountsApplicable'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$HotelBasicDetailsModelToJson(
        HotelBasicDetailsModel instance) =>
    <String, dynamic>{
      'hotelName': instance.hotelName,
      'doorNumber': instance.doorNumber,
      'streetNumber': instance.streetNumber,
      'cityName': instance.cityName,
      'id': instance.id,
      'mainImage': instance.mainImage,
      'locations': instance.locationsModel,
      'highlights': instance.highlights,
      'discountsApplicable': instance.discountsApplicable,
    };
