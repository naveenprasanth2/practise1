import 'package:json_annotation/json_annotation.dart';

part 'room_info_model.g.dart';


@JsonSerializable()
class RoomInfoModel {
  @JsonKey(name: 'imageUrl')
  String imageUrl;

  @JsonKey(name: 'price')
  int price;

  RoomInfoModel({
    required this.imageUrl,
    required this.price
});

  factory RoomInfoModel.fromJson(Map<String, dynamic> json) => _$RoomInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomInfoModelToJson(this);
}