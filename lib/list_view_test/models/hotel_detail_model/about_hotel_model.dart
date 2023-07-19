import 'package:json_annotation/json_annotation.dart';

part 'about_hotel_model.g.dart';

@JsonSerializable()
class AboutHotelModel {
  @JsonKey(name: 'Description')
  String description;

  @JsonKey(name: 'Special Features')
  String specialFeatures;

  @JsonKey(name: 'Location & Transportation')
  String locationAndTransportation;

  AboutHotelModel({
    required this.description,
    required this.specialFeatures,
    required this.locationAndTransportation,
  });

  // A factory constructor to create an instance from a JSON object
  factory AboutHotelModel.fromJson(Map<String, dynamic> json) =>
      _$AboutHotelModelFromJson(json);

  // A method to convert the instance to a JSON object
  Map<String, dynamic> toJson() => _$AboutHotelModelToJson(this);
}
