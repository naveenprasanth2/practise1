import 'package:json_annotation/json_annotation.dart';
import 'package:practise1/hotel_booking/models/hotel_detail_model/room_type_model.dart';
import 'package:practise1/hotel_booking/models/hotel_images_model/hotel_images_model.dart';

import '../amenities_model/amenities_model.dart';
import '../guest_policies/guest_policy_model.dart';
import '../nearby_places_model/nearby_places_model.dart';
import 'about_hotel_model.dart';

part 'hotel_details_model_v2.g.dart';

@JsonSerializable()
class HotelDetailsModel {
  @JsonKey(name: 'hotelName')
  String hotelName;

  @JsonKey(name: 'doorNumber')
  String doorNumber;

  @JsonKey(name: 'streetNumber')
  String streetNumber;

  @JsonKey(name: 'cityAndState')
  String cityAndState;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'mainImage')
  String mainImage;

  @JsonKey(name: 'hotelImages')
  HotelImagesModel hotelImages;

  @JsonKey(name: 'locationDetails')
  NearbyPlacesModel locationDetails;

  @JsonKey(name: 'highlights')
  List<String> highlights;

  @JsonKey(name: 'guestPolicies')
  List<GuestPolicyModel> guestPolicies;

  @JsonKey(name: 'aboutHotel')
  AboutHotelModel aboutHotelModel;

  @JsonKey(name: 'discountsApplicable')
  List<int> discountsApplicable;

  @JsonKey(name: 'roomType')
  List<RoomTypeModel> roomType;

  @JsonKey(name: 'amenities')
  AmenitiesModel amenities;

  HotelDetailsModel(
      {required this.hotelName,
      required this.doorNumber,
      required this.streetNumber,
      required this.cityAndState,
      required this.id,
      required this.mainImage,
      required this.hotelImages,
      required this.locationDetails,
      required this.highlights,
      required this.guestPolicies,
      required this.aboutHotelModel,
      required this.discountsApplicable,
      required this.roomType,
      required this.amenities});

  factory HotelDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$HotelDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelDetailsModelToJson(this);
}
