// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingHistoryModel _$BookingHistoryModelFromJson(Map<String, dynamic> json) =>
    BookingHistoryModel(
      hotelName: json['hotelName'] as String,
      doorNumber: json['doorNumber'] as String,
      streetNumber: json['streetNumber'] as String,
      cityName: json['cityName'] as String,
      guestsCount: json['guestsCount'] as int,
      checkInDate: json['checkInDate'] as String,
      checkInTime: json['checkInTime'] as String,
      checkOutDate: json['checkOutDate'] as String,
      checkOutTime: json['checkOutTime'] as String,
      bookingId: json['BookingId'] as String,
      reservedFor: json['reservedFor'] as String,
      amountPaid: json['amountPaid'] as int,
      discount: json['discount'] as int,
      iconImage: json['iconImage'] as String,
    );

Map<String, dynamic> _$BookingHistoryModelToJson(
        BookingHistoryModel instance) =>
    <String, dynamic>{
      'hotelName': instance.hotelName,
      'doorNumber': instance.doorNumber,
      'streetNumber': instance.streetNumber,
      'cityName': instance.cityName,
      'guestsCount': instance.guestsCount,
      'checkInDate': instance.checkInDate,
      'checkInTime': instance.checkInTime,
      'checkOutDate': instance.checkOutDate,
      'checkOutTime': instance.checkOutTime,
      'BookingId': instance.bookingId,
      'reservedFor': instance.reservedFor,
      'amountPaid': instance.amountPaid,
      'discount': instance.discount,
      'iconImage': instance.iconImage,
    };
