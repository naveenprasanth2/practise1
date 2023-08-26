// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_type_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomTypeSearchModel _$RoomTypeSearchModelFromJson(Map<String, dynamic> json) =>
    RoomTypeSearchModel(
      type: json['type'] as String,
      size: json['size'] as int,
      maxPeopleAllowed: json['maxPeopleAllowed'] as int,
      price: json['price'] as int,
      discountedPrice: json['discountedPrice'] as int,
    );

Map<String, dynamic> _$RoomTypeSearchModelToJson(
        RoomTypeSearchModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'size': instance.size,
      'maxPeopleAllowed': instance.maxPeopleAllowed,
      'price': instance.price,
      'discountedPrice': instance.discountedPrice,
    };
