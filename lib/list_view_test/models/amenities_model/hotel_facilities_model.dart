import 'package:json_annotation/json_annotation.dart';

part 'hotel_facilities_model.g.dart';

@JsonSerializable()
class HotelFacilitiesModel {
  @JsonKey(name: 'ac')
  bool? ac;

  @JsonKey(name: 'wifi')
  bool? wifi;

  @JsonKey(name: 'kitchen')
  bool? kitchen;

  @JsonKey(name: 'restaurant')
  bool? restaurant;

  @JsonKey(name: 'reception')
  bool? reception;

  @JsonKey(name: 'careTaker')
  bool? careTaker;

  @JsonKey(name: 'security')
  bool? security;

  @JsonKey(name: 'shuttleService')
  bool? shuttleService;

  @JsonKey(name: 'luggageAssistance')
  bool? luggageAssistance;

  @JsonKey(name: 'taxi')
  bool? taxi;

  @JsonKey(name: 'dailyHousekeeping')
  bool? dailyHousekeeping;

  @JsonKey(name: 'fireExtinguisher')
  bool? fireExtinguisher;

  @JsonKey(name: 'firstAidKit')
  bool? firstAidKit;

  HotelFacilitiesModel({
    this.ac,
    this.wifi,
    this.kitchen,
    this.restaurant,
    this.reception,
    this.careTaker,
    this.security,
    this.shuttleService,
    this.luggageAssistance,
    this.taxi,
    this.dailyHousekeeping,
    this.fireExtinguisher,
    this.firstAidKit
  });

  Map<String, bool> hotelFacilitiesModelData() {
    var originalData = toJson();
    Map<String, bool> hotelFacilitiesModelData = originalData.map((key, value) {
      return MapEntry(key, value as bool);
    });
    return hotelFacilitiesModelData;
  }

  factory HotelFacilitiesModel.fromJson(Map<String, dynamic> json) =>
      _$HotelFacilitiesModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelFacilitiesModelToJson(this);
}
