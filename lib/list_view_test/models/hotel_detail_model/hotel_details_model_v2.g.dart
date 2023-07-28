// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_details_model_v2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelDetailsModel _$HotelDetailsModelFromJson(Map<String, dynamic> json) =>
    HotelDetailsModel(
      hotelName: json['hotelName'] as String,
      doorNumber: json['doorNumber'] as String,
      streetNumber: json['streetNumber'] as String,
      cityName: json['cityName'] as String,
      id: json['id'] as String,
      averageRatings: (json['averageRatings'] as num).toDouble(),
      noOfRatings: json['noOfRatings'] as int,
      mainImage: json['mainImage'] as String,
      hotelImages: (json['hotelImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      locations:
          LocationsModel.fromJson(json['locations'] as Map<String, dynamic>),
      highlights: (json['highlights'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      guestPolicies: (json['guestPolicies'] as List<dynamic>)
          .map((e) => GuestPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      aboutHotelModel:
          AboutHotelModel.fromJson(json['aboutHotel'] as Map<String, dynamic>),
      discountsApplicable: (json['discountsApplicable'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      roomType:
          RoomTypeModel.fromJson(json['roomType'] as Map<String, dynamic>),
      amenities:
          AmenitiesModel.fromJson(json['amenities'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HotelDetailsModelToJson(HotelDetailsModel instance) =>
    <String, dynamic>{
      'hotelName': instance.hotelName,
      'doorNumber': instance.doorNumber,
      'streetNumber': instance.streetNumber,
      'cityName': instance.cityName,
      'id': instance.id,
      'averageRatings': instance.averageRatings,
      'noOfRatings': instance.noOfRatings,
      'mainImage': instance.mainImage,
      'hotelImages': instance.hotelImages,
      'locations': instance.locations,
      'highlights': instance.highlights,
      'guestPolicies': instance.guestPolicies,
      'aboutHotel': instance.aboutHotelModel,
      'discountsApplicable': instance.discountsApplicable,
      'roomType': instance.roomType,
      'amenities': instance.amenities,
    };
