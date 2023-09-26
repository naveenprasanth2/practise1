import 'package:flutter/material.dart';
import 'package:practise1/hotel_booking/models/coupon_model/coupon_model.dart';

class CouponStateProvider extends ChangeNotifier {
  String _couponCode = "";
  CouponModel? _selectedCoupon;

  void setCouponCode(CouponModel coupon) {
    _couponCode = coupon.couponCode;
    _selectedCoupon = coupon;
    notifyListeners();
  }

  String get couponCode => _couponCode;
  CouponModel? get selectedCoupon => _selectedCoupon;

  void removeCouponCode() {
    _couponCode = "";
    _selectedCoupon = null;
    notifyListeners();
  }
}
