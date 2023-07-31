import 'package:json_annotation/json_annotation.dart';

part 'place_category_model.g.dart';

@JsonSerializable()
class PlaceCategoryModel {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'lat')
  final double lat;
  @JsonKey(name: 'lng')
  final double lng;

  PlaceCategoryModel({
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory PlaceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceCategoryModelToJson(this);
}