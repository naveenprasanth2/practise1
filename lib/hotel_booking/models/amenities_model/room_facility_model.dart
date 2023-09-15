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
      this.books
      );

  Map<String, bool> roomFacilityModelData() {
    var originalData = toJson();
    Map<String, bool> roomFacilityModelData = originalData.map((key, value) {
      return MapEntry(key, value as bool);
    });
    return roomFacilityModelData;
  }


  factory RoomFacilityModel.fromJson(Map<String, dynamic> json) =>
      _$RoomFacilityModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomFacilityModelToJson(this);
}
