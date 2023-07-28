// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_images_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelImagesModel _$HotelImagesModelFromJson(Map<String, dynamic> json) =>
    HotelImagesModel(
      room: (json['room'] as List<dynamic>).map((e) => e as String).toList(),
      others:
          (json['others'] as List<dynamic>).map((e) => e as String).toList(),
      washroom:
          (json['washroom'] as List<dynamic>).map((e) => e as String).toList(),
      lobby: (json['lobby'] as List<dynamic>).map((e) => e as String).toList(),
      reception:
          (json['reception'] as List<dynamic>).map((e) => e as String).toList(),
      facade:
          (json['facade'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HotelImagesModelToJson(HotelImagesModel instance) =>
    <String, dynamic>{
      'room': instance.room,
      'others': instance.others,
      'washroom': instance.washroom,
      'lobby': instance.lobby,
      'reception': instance.reception,
      'facade': instance.facade,
    };
