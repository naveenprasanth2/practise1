// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelSmallDetailsModel _$HotelSmallDetailsModelFromJson(
        Map<String, dynamic> json) =>
    HotelSmallDetailsModel(
      hotelName: json['hotelName'] as String,
      townName: json['townName'] as String,
      cityName: json['cityName'] as String,
      mapViewData: json['mapViewData'] as String,
    );

Map<String, dynamic> _$HotelSmallDetailsModelToJson(
        HotelSmallDetailsModel instance) =>
    <String, dynamic>{
      'hotelName': instance.hotelName,
      'townName': instance.townName,
      'cityName': instance.cityName,
      'mapViewData': instance.mapViewData,
    };
