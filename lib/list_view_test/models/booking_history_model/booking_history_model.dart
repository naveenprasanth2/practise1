import 'package:json_annotation/json_annotation.dart';

part 'booking_history_model.g.dart';

@JsonSerializable()
class BookingHistoryModel {
  @JsonKey(name: 'hotelId')
  final String hotelId;
  @JsonKey(name: 'cityAndState')
  final String cityAndState;
  @JsonKey(name: 'roomsCount')
  final int roomsCount;
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
  @JsonKey(name: 'bookingId')
  final String bookingId;
  @JsonKey(name: 'checkOutStatus')
  final String checkOutStatus;
  @JsonKey(name: 'rated')
  final bool rated;
  @JsonKey(name: 'reservedFor')
  final String reservedFor;
  @JsonKey(name: 'amountPaid')
  final int amountPaid;
  @JsonKey(name: 'discount')
  final int discount;
  @JsonKey(name: 'discountCoupon')
  final String discountCoupon;

  BookingHistoryModel({
    required this.hotelId,
    required this.cityAndState,
    required this.roomsCount,
    required this.guestsCount,
    required this.checkInDate,
    required this.checkInTime,
    required this.checkOutDate,
    required this.checkOutTime,
    required this.bookingId,
    required this.checkOutStatus,
    required this.rated,
    required this.reservedFor,
    required this.amountPaid,
    required this.discount,
    required this.discountCoupon,
  });

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$BookingHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingHistoryModelToJson(this);
}
