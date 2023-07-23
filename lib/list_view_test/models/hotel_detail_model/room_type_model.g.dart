// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomTypeModel _$RoomTypeModelFromJson(Map<String, dynamic> json) =>
    RoomTypeModel(
      standardRoom:
          RoomInfoModel.fromJson(json['standardRoom'] as Map<String, dynamic>),
      doubleRoom:
          RoomInfoModel.fromJson(json['doubleRoom'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomTypeModelToJson(RoomTypeModel instance) =>
    <String, dynamic>{
      'standardRoom': instance.standardRoom,
      'doubleRoom': instance.doubleRoom,
    };
