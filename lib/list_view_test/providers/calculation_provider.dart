import 'package:flutter/material.dart';

class CalculationProvider extends ChangeNotifier {
  double? _costPerNight;
  double? _discountPercentage;
  double? _gstPercentage;
  double? _prepaidDiscountPercentage;
  double? _finalPrice;
  double? _totalAmount;

  double? get costPerNight => _costPerNight;

  double? get discount => _discountPercentage;

  double? get gstPercentage => _gstPercentage;

  double? get prepaidDiscount => _prepaidDiscountPercentage;

  double? get finalPrice => _finalPrice;

  double? get totalAmount => _totalAmount;

  void setCostPerNight(int costPerNight) {
    _costPerNight = costPerNight.toDouble();
    notifyListeners();
  }

  void setDiscountPercentage(int discountPercentage) {
    _discountPercentage = discountPercentage.toDouble();
    notifyListeners();
  }

  void setGstPercentage(double gstPercentage) {
    _gstPercentage = gstPercentage;
    notifyListeners();
  }

  void setPrepaidDiscountPercentage(double prepaidDiscountPercentage) {
    _prepaidDiscountPercentage = prepaidDiscountPercentage;
    notifyListeners();
  }

  void setFinalPrice() {
    _gstPercentage = gstPercentage;
    notifyListeners();
  }
}
