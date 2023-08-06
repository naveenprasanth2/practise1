// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomTypeModel _$RoomTypeModelFromJson(Map<String, dynamic> json) =>
    RoomTypeModel(
      type: json['type'] as String,
      imageUrls:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      size: json['size'] as int,
      maxPeopleAllowed: json['maxPeopleAllowed'] as int,
      roomPrice: json['price'] as int,
    );

Map<String, dynamic> _$RoomTypeModelToJson(RoomTypeModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'images': instance.imageUrls,
      'size': instance.size,
      'maxPeopleAllowed': instance.maxPeopleAllowed,
      'price': instance.roomPrice,
    };
