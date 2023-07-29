import 'package:json_annotation/json_annotation.dart';

import 'locations_model.dart';

part 'hotel_basic_details_model.g.dart';

@JsonSerializable()
class HotelBasicDetailsModel {
  @JsonKey(name: 'hotelName')
  String hotelName;

  @JsonKey(name: 'doorNumber')
  String doorNumber;

  @JsonKey(name: 'streetNumber')
  String streetNumber;

  @JsonKey(name: 'cityName')
  String cityName;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'mainImage')
  String mainImage;

  @JsonKey(name: 'locations')
  LocationsModel locationsModel;

  @JsonKey(name: 'highlights')
  List<String> highlights;

  @JsonKey(name: 'discountsApplicable')
  List<int> discountsApplicable;

  HotelBasicDetailsModel({
    required this.hotelName,
    required this.doorNumber,
    required this.streetNumber,
    required this.cityName,
    required this.id,
    required this.mainImage,
    required this.locationsModel,
    required this.highlights,
    required this.discountsApplicable,
  }); // A factory constructor to create an instance from a JSON object
  factory HotelBasicDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$HotelBasicDetailsModelFromJson(json);

  // A method to convert the instance to a JSON object
  Map<String, dynamic> toJson() => _$HotelBasicDetailsModelToJson(this);
}
