import 'package:json_annotation/json_annotation.dart';

part 'room_type_search_model.g.dart';

@JsonSerializable()
class RoomTypeSearchModel {
  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'size')
  final int size;

  @JsonKey(name: 'maxPeopleAllowed')
  final int maxPeopleAllowed;

  @JsonKey(name: 'price')
  final int price;

  @JsonKey(name: 'discountedPrice')
  final int discountedPrice;

  RoomTypeSearchModel({
    required this.type,
    required this.size,
    required this.maxPeopleAllowed,
    required this.price,
    required this.discountedPrice,
  });

  factory RoomTypeSearchModel.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomTypeSearchModelToJson(this);

  // Builder pattern for creating instances
  RoomTypeSearchModel copyWith({
    String? type,
    int? size,
    int? maxPeopleAllowed,
    int? price,
    int? discountedPrice,
  }) {
    return RoomTypeSearchModel(
      type: type ?? this.type,
      size: size ?? this.size,
      maxPeopleAllowed: maxPeopleAllowed ?? this.maxPeopleAllowed,
      price: price ?? this.price,
      discountedPrice: discountedPrice ?? this.discountedPrice,
    );
  }
}
