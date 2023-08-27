import 'package:json_annotation/json_annotation.dart';

part 'room_type_model.g.dart';

@JsonSerializable()
class RoomTypeModel {
  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'images')
  final List<String> imageUrls;

  @JsonKey(name: 'size')
  final int size;

  @JsonKey(name: 'maxPeopleAllowed')
  final int maxPeopleAllowed;

  @JsonKey(name: 'price')
  final double roomPrice;

  RoomTypeModel({
    required this.type,
    required this.imageUrls,
    required this.size,
    required this.maxPeopleAllowed,
    required this.roomPrice,
  });

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) => _$RoomTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomTypeModelToJson(this);
}
