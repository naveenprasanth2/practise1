// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_facilities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelFacilitiesModel _$HotelFacilitiesModelFromJson(
        Map<String, dynamic> json) =>
    HotelFacilitiesModel(
      ac: json['ac'] as bool?,
      wifi: json['wifi'] as bool?,
      kitchen: json['kitchen'] as bool?,
      restaurant: json['restaurant'] as bool?,
      reception: json['reception'] as bool?,
      careTaker: json['careTaker'] as bool?,
      security: json['security'] as bool?,
      shuttleService: json['shuttleService'] as bool?,
      luggageAssistance: json['luggageAssistance'] as bool?,
      taxi: json['taxi'] as bool?,
      dailyHousekeeping: json['dailyHousekeeping'] as bool?,
      fireExtinguisher: json['fireExtinguisher'] as bool?,
      firstAidKit: json['firstAidKit'] as bool?,
    );

Map<String, dynamic> _$HotelFacilitiesModelToJson(
        HotelFacilitiesModel instance) =>
    <String, dynamic>{
      'ac': instance.ac,
      'wifi': instance.wifi,
      'kitchen': instance.kitchen,
      'restaurant': instance.restaurant,
      'reception': instance.reception,
      'careTaker': instance.careTaker,
      'security': instance.security,
      'shuttleService': instance.shuttleService,
      'luggageAssistance': instance.luggageAssistance,
      'taxi': instance.taxi,
      'dailyHousekeeping': instance.dailyHousekeeping,
      'fireExtinguisher': instance.fireExtinguisher,
      'firstAidKit': instance.firstAidKit,
    };
