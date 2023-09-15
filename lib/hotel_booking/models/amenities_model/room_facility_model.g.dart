// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_facility_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomFacilityModel _$RoomFacilityModelFromJson(Map<String, dynamic> json) =>
    RoomFacilityModel(
      json['extraMattress'] as bool?,
      json['smokeDetector'] as bool?,
      json['interCom'] as bool?,
      json['books'] as bool?,
    );

Map<String, dynamic> _$RoomFacilityModelToJson(RoomFacilityModel instance) =>
    <String, dynamic>{
      'extraMattress': instance.extraMattress,
      'smokeDetector': instance.smokeDetector,
      'interCom': instance.interCom,
      'books': instance.books,
    };
