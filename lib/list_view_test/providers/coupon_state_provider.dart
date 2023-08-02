import 'package:flutter/material.dart';

class CouponStateProvider extends ChangeNotifier{
  String _couponCode = "";

  void setCouponCode(String code){
    _couponCode = code;
    notifyListeners();
  }

  String get couponCode => _couponCode;

  void removeCouponCode(){
    _couponCode = "";
    notifyListeners();
  }
}