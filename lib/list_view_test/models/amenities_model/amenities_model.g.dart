// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amenities_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmenitiesModel _$AmenitiesModelFromJson(Map<String, dynamic> json) =>
    AmenitiesModel(
      json['bedTypeModel'] == null
          ? null
          : BedTypeModel.fromJson(json['bedTypeModel'] as Map<String, dynamic>),
      json['hotelFacilitiesModel'] == null
          ? null
          : HotelFacilitiesModel.fromJson(
              json['hotelFacilitiesModel'] as Map<String, dynamic>),
      json['mediaTechnologyModel'] == null
          ? null
          : MediaTechnologyModel.fromJson(
              json['mediaTechnologyModel'] as Map<String, dynamic>),
      json['roomFacilityModel'] == null
          ? null
          : RoomFacilityModel.fromJson(
              json['roomFacilityModel'] as Map<String, dynamic>),
      json['washroomModel'] == null
          ? null
          : WashroomModel.fromJson(
              json['washroomModel'] as Map<String, dynamic>),
      json['seatingAreaModel'] == null
          ? null
          : SeatingAreaModel.fromJson(
              json['seatingAreaModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AmenitiesModelToJson(AmenitiesModel instance) =>
    <String, dynamic>{
      'bedTypeModel': instance.bedTypeModel,
      'hotelFacilitiesModel': instance.hotelFacilitiesModel,
      'mediaTechnologyModel': instance.mediaTechnologyModel,
      'roomFacilityModel': instance.roomFacilityModel,
      'washroomModel': instance.washroomModel,
      'seatingAreaModel': instance.seatingAreaModel,
    };
