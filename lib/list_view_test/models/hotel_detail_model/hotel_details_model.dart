import 'package:json_annotation/json_annotation.dart';

part 'hotel_details_model.g.dart';

@JsonSerializable()
class HotelSmallDetailsModel {
  @JsonKey(name: 'hotelName')
  String hotelName;

  @JsonKey(name: 'townName')
  String townName;

  @JsonKey(name: 'cityName')
  String cityName;

  @JsonKey(name: 'mapViewData')
  String mapViewData;

  HotelSmallDetailsModel({
    required this.hotelName,
    required this.townName,
    required this.cityName,
    required this.mapViewData,
  });

  factory HotelSmallDetailsModel.fromJson(Map<String, dynamic> json) => _$HotelSmallDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelSmallDetailsModelToJson(this);
}
