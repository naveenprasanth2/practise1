import 'package:json_annotation/json_annotation.dart';
import 'package:practise1/list_view_test/models/hotel_detail_model/room_info_model.dart';

part 'room_type_model.g.dart';

@JsonSerializable()
class RoomTypeModel {
  @JsonKey(name: 'standardRoom')
  RoomInfoModel standardRoom;

  @JsonKey(name: 'doubleRoom')
  RoomInfoModel doubleRoom;

  RoomTypeModel({required this.standardRoom, required this.doubleRoom});

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomTypeModelToJson(this);
}
