import 'booking_history_model.dart';

class HotelDetailsSplitJson {
  final String hotelId;
  final String cityAndState;

  HotelDetailsSplitJson.fromBookingHistoryModel(
      BookingHistoryModel bookingHistoryModel)
      : hotelId = bookingHistoryModel.hotelId,
        cityAndState = bookingHistoryModel.cityAndState;

  Map<String, dynamic> toJson() {
    return {
      'hotelId': hotelId,
      'cityAndState': cityAndState,
    };
  }
}

class BookingScheduleSplitJson {
  final String checkInDate;
  final String checkInTime;
  final String checkOutDate;
  final String checkOutTime;
  final int roomsCount;
  final int guestsCount;

  BookingScheduleSplitJson.fromBookingHistoryModel(
      BookingHistoryModel bookingHistoryModel)
      : checkInDate = bookingHistoryModel.checkInDate,
        checkInTime = bookingHistoryModel.checkInTime,
        checkOutDate = bookingHistoryModel.checkOutDate,
        checkOutTime = bookingHistoryModel.checkOutTime,
        roomsCount = bookingHistoryModel.roomsCount,
        guestsCount = bookingHistoryModel.guestsCount;

  Map<String, dynamic> toJson() {
    return {
      'checkInDate': checkInDate,
      'checkInTime': checkInTime,
      'checkOutDate': checkOutDate,
      'checkOutTime': checkOutTime,
      'roomsCount': roomsCount,
      'guestsCount': guestsCount,
    };
  }
}

class BookingStatusSplitJson {
  final String bookingId;
  final String checkOutStatus;
  final bool rated;

  BookingStatusSplitJson.fromBookingHistoryModel(
      BookingHistoryModel bookingHistoryModel)
      : bookingId = bookingHistoryModel.bookingId,
        checkOutStatus = bookingHistoryModel.checkOutStatus,
        rated = bookingHistoryModel.rated;

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'checkOutStatus': checkOutStatus,
      'rated': rated,
    };
  }
}

class PaymentDetailsSplitJson {
  final String reservedFor;
  final double amountPaid;
  final double discount;
  final String discountCoupon;

  PaymentDetailsSplitJson.fromBookingHistoryModel(
      BookingHistoryModel bookingHistoryModel)
      : reservedFor = bookingHistoryModel.reservedFor,
        amountPaid = bookingHistoryModel.amountPaid.toDouble(),
        discount = bookingHistoryModel.discount.toDouble(),
        discountCoupon = bookingHistoryModel.discountCoupon;

  Map<String, dynamic> toJson() {
    return {
      'reservedFor': reservedFor,
      'amountPaid': amountPaid,
      'discount': discount,
      'discountCoupon': discountCoupon,
    };
  }
}
