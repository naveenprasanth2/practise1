import 'package:json_annotation/json_annotation.dart';

part 'room_facility_model.g.dart';

@JsonSerializable()
class RoomFacilityModel {
  @JsonKey(name: 'extraMattress')
  bool? extraMattress;

  @JsonKey(name: 'smokeDetector')
  bool? smokeDetector;

  @JsonKey(name: 'interCom')
  bool? interCom;

  @JsonKey(name: 'books')
  bool? books;

  RoomFacilityModel(
      this.extraMattress,
      this.smokeDetector,
      this.interCom,
      this.books,
      );

  factory RoomFacilityModel.fromJson(Map<String, dynamic> json) =>
      _$RoomFacilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomFacilityModelToJson(this);
}
