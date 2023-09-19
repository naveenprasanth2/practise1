// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_occupancy_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomOccupancyDetailsModel _$RoomOccupancyDetailsModelFromJson(
        Map<String, dynamic> json) =>
    RoomOccupancyDetailsModel(
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      primaryGuest: json['primaryGuest'] as String,
    );

Map<String, dynamic> _$RoomOccupancyDetailsModelToJson(
        RoomOccupancyDetailsModel instance) =>
    <String, dynamic>{
      'rooms': instance.rooms,
      'primaryGuest': instance.primaryGuest,
    };
