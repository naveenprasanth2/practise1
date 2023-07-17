import 'package:json_annotation/json_annotation.dart';

part 'booking_history_model.g.dart';

@JsonSerializable()
class BookingHistoryModel {
  @JsonKey(name: 'hotelName')
  final String hotelName;
  @JsonKey(name: 'doorNumber')
  final String doorNumber;
  @JsonKey(name: 'streetNumber')
  final String streetNumber;
  @JsonKey(name: 'cityName')
  final String cityName;
  @JsonKey(name: 'guestsCount')
  final int guestsCount;
  @JsonKey(name: 'checkInDate')
  final String checkInDate;
  @JsonKey(name: 'checkInTime')
  final String checkInTime;
  @JsonKey(name: 'checkOutDate')
  final String checkOutDate;
  @JsonKey(name: 'checkOutTime')
  final String checkOutTime;
  @JsonKey(name: 'BookingId')
  final String bookingId;
  @JsonKey(name: 'checkOutStatus')
  final String checkOutStatus;
  @JsonKey(name: 'reservedFor')
  final String reservedFor;
  @JsonKey(name: 'amountPaid')
  final int amountPaid;
  @JsonKey(name: 'discount')
  final int discount;
  @JsonKey(name: 'iconImage')
  final String iconImage;

  BookingHistoryModel({
    required this.hotelName,
    required this.doorNumber,
    required this.streetNumber,
    required this.cityName,
    required this.guestsCount,
    required this.checkInDate,
    required this.checkInTime,
    required this.checkOutDate,
    required this.checkOutTime,
    required this.bookingId,
    required this.checkOutStatus,
    required this.reservedFor,
    required this.amountPaid,
    required this.discount,
    required this.iconImage,
  });

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$BookingHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingHistoryModelToJson(this);
}
