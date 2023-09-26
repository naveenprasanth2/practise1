import 'package:json_annotation/json_annotation.dart';

import '../hotel_search/hotel_search_model.dart';
import 'booking_history_model.dart';

part 'booking_history_display_model.g.dart';

@JsonSerializable()
class BookingHistoryDisplayModel {
  @JsonKey(name: 'bookingHistoryModel')
  final BookingHistoryModel bookingHistoryModel;
  @JsonKey(name: 'hotelSearchModel')
  final HotelSearchModel hotelSearchModel;

  BookingHistoryDisplayModel({
    required this.bookingHistoryModel,
    required this.hotelSearchModel,
  });

  factory BookingHistoryDisplayModel.fromJson(Map<String, dynamic> json) =>
      _$BookingHistoryDisplayModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingHistoryDisplayModelToJson(this);
}
