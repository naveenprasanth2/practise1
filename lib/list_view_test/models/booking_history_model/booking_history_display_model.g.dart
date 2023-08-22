// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_history_display_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingHistoryDisplayModel _$BookingHistoryDisplayModelFromJson(
        Map<String, dynamic> json) =>
    BookingHistoryDisplayModel(
      bookingHistoryModel: BookingHistoryModel.fromJson(
          json['bookingHistoryModel'] as Map<String, dynamic>),
      hotelSearchModel: HotelSearchModel.fromJson(
          json['hotelSearchModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingHistoryDisplayModelToJson(
        BookingHistoryDisplayModel instance) =>
    <String, dynamic>{
      'bookingHistoryModel': instance.bookingHistoryModel,
      'hotelSearchModel': instance.hotelSearchModel,
    };
