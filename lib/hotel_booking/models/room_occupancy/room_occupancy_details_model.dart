import 'package:json_annotation/json_annotation.dart';
import 'room_model.dart';

part 'room_occupancy_details_model.g.dart';

@JsonSerializable()
class RoomOccupancyDetailsModel {
  @JsonKey(name: 'rooms')
  List<RoomModel> rooms;

  @JsonKey(name: 'primaryGuest')
  String primaryGuest;

  RoomOccupancyDetailsModel({required this.rooms, required this.primaryGuest});

  factory RoomOccupancyDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$RoomOccupancyDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomOccupancyDetailsModelToJson(this);
}
