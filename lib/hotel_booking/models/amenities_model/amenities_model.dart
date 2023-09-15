import 'package:json_annotation/json_annotation.dart';
import 'bed_type_model.dart';
import 'hotel_facilities_model.dart';
import 'media_technology_model.dart';
import 'room_facility_model.dart';
import 'seating_area_model.dart';
import 'washroom_model.dart';

part 'amenities_model.g.dart';

@JsonSerializable()
class AmenitiesModel {
  @JsonKey(name: 'bedTypeModel')
  BedTypeModel? bedTypeModel;

  @JsonKey(name: 'hotelFacilitiesModel')
  HotelFacilitiesModel? hotelFacilitiesModel;

  @JsonKey(name: 'mediaTechnologyModel')
  MediaTechnologyModel? mediaTechnologyModel;

  @JsonKey(name: 'roomFacilityModel')
  RoomFacilityModel? roomFacilityModel;

  @JsonKey(name: 'washroomModel')
  WashroomModel? washroomModel;

  @JsonKey(name: 'seatingAreaModel')
  SeatingAreaModel? seatingAreaModel;

  AmenitiesModel(
    this.bedTypeModel,
    this.hotelFacilitiesModel,
    this.mediaTechnologyModel,
    this.roomFacilityModel,
    this.washroomModel,
    this.seatingAreaModel,
  );

  factory AmenitiesModel.fromJson(Map<String, dynamic> json) =>
      _$AmenitiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$AmenitiesModelToJson(this);
}
