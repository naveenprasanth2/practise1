// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingHistoryModel _$BookingHistoryModelFromJson(Map<String, dynamic> json) =>
    BookingHistoryModel(
      hotelId: json['hotelId'] as String,
      cityAndState: json['cityAndState'] as String,
      roomsCount: json['roomsCount'] as int,
      roomType: json['roomType'] as String,
      guestsCount: json['guestsCount'] as int,
      checkInDate: json['checkInDate'] as String,
      checkInTime: json['checkInTime'] as String,
      checkOutDate: json['checkOutDate'] as String,
      checkOutTime: json['checkOutTime'] as String,
      bookingId: json['bookingId'] as String,
      userId: json['userId'] as String,
      checkOutStatus: json['checkOutStatus'] as String,
      rated: json['rated'] as bool,
      reservedFor: json['reservedFor'] as String,
      amountPaid: json['amountPaid'] as int,
      discount: json['discount'] as int,
      discountCoupon: json['discountCoupon'] as String,
      paymentMode: json['paymentMode'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
    );

Map<String, dynamic> _$BookingHistoryModelToJson(
        BookingHistoryModel instance) =>
    <String, dynamic>{
      'hotelId': instance.hotelId,
      'cityAndState': instance.cityAndState,
      'roomsCount': instance.roomsCount,
      'roomType': instance.roomType,
      'guestsCount': instance.guestsCount,
      'checkInDate': instance.checkInDate,
      'checkInTime': instance.checkInTime,
      'checkOutDate': instance.checkOutDate,
      'checkOutTime': instance.checkOutTime,
      'userId': instance.userId,
      'bookingId': instance.bookingId,
      'checkOutStatus': instance.checkOutStatus,
      'rated': instance.rated,
      'reservedFor': instance.reservedFor,
      'amountPaid': instance.amountPaid,
      'discount': instance.discount,
      'discountCoupon': instance.discountCoupon,
      'paymentMode': instance.paymentMode,
      'paymentStatus': instance.paymentStatus,
    };
