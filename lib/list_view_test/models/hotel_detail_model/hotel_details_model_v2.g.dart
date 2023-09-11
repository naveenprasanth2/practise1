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
      cityAndState: json['cityAndState'] as String,
      id: json['id'] as String,
      mainImage: json['mainImage'] as String,
      hotelImages: HotelImagesModel.fromJson(
          json['hotelImages'] as Map<String, dynamic>),
      locationDetails: NearbyPlacesModel.fromJson(
          json['locationDetails'] as Map<String, dynamic>),
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
      roomType: (json['roomType'] as List<dynamic>)
          .map((e) => RoomTypeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      amenities:
          AmenitiesModel.fromJson(json['amenities'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HotelDetailsModelToJson(HotelDetailsModel instance) =>
    <String, dynamic>{
      'hotelName': instance.hotelName,
      'doorNumber': instance.doorNumber,
      'streetNumber': instance.streetNumber,
      'cityAndState': instance.cityAndState,
      'id': instance.id,
      'mainImage': instance.mainImage,
      'hotelImages': instance.hotelImages,
      'locationDetails': instance.locationDetails,
      'highlights': instance.highlights,
      'guestPolicies': instance.guestPolicies,
      'aboutHotel': instance.aboutHotelModel,
      'discountsApplicable': instance.discountsApplicable,
      'roomType': instance.roomType,
      'amenities': instance.amenities,
    };
