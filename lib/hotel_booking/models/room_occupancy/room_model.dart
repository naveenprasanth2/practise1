import 'package:json_annotation/json_annotation.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  @JsonKey(name: 'adults')
  int adults;

  @JsonKey(name: 'children')
  int children;

  RoomModel({
    this.adults = 1,
    this.children = 0,
  });
  RoomModel clone() {
    return RoomModel(adults: adults, children: children);
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
