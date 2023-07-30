import 'package:json_annotation/json_annotation.dart';

part 'office_model.g.dart';

@JsonSerializable()
class OfficeModel {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'address')
  final String address;

  @JsonKey(name: 'lat')
  final double lat;

  @JsonKey(name: 'lng')
  final double lng;

  OfficeModel(this.name, this.address, this.lat, this.lng);

  factory OfficeModel.fromJson(Map<String, dynamic> json) => _$OfficeModelFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeModelToJson(this);
}
