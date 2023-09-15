import 'package:json_annotation/json_annotation.dart';

part 'locations_model.g.dart';

@JsonSerializable()
class LocationsModel {
  @JsonKey(name: 'latitude')
  double latitude;

  @JsonKey(name: 'longitude')
  double longitude;

  LocationsModel({
    required this.latitude,
    required this.longitude
});

  factory LocationsModel.fromJson(Map<String, dynamic> json) => _$LocationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsModelToJson(this);
}