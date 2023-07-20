import 'package:flutter/material.dart';

class CalculationProvider extends ChangeNotifier {
  double? _costPerNight;
  double? _discountPercentage;
  double? _discountedPrice;
  double? _pretaxPrice;
  double? _gstPercentage;
  double? _gstPrice;
  double? _afterTaxPrice;
  double? _prepaidDiscountPercentage;
  double? _prepaidDiscountValue;
  double? _finalPriceWithoutPrepaidDiscount;
  double? _finalPrice;
  double? _totalAmount;

  double? get costPerNight => _costPerNight;

  double? get discountPercentage => _discountPercentage;

  double? get discountedPrice => _discountedPrice;

  double? get pretaxPrice => _pretaxPrice;

  double? get gstPercentage => _gstPercentage;

  double? get gstPrice => _gstPrice;

  double? get afterTaxPrice => _afterTaxPrice;

  double? get prepaidDiscount => _prepaidDiscountPercentage;

  double? get prepaidDiscountValue => _prepaidDiscountValue;

  double? get finalPriceWithoutPrepaidDiscount =>
      _finalPriceWithoutPrepaidDiscount;

  double? get finalPrice => _finalPrice;

  double? get totalAmount => _totalAmount;

  void setCostPerNight(int costPerNight) {
    _costPerNight = costPerNight.toDouble();
    notifyListeners();
  }

  void setDiscountPercentage(int discountPercentage) {
    _discountPercentage = discountPercentage.toDouble();
    _discountedPrice = (costPerNight! * discountPercentage) / 100;
    _pretaxPrice = (costPerNight! - discountedPrice!);
    notifyListeners();
  }

  void setGstPercentage(double gstPercentage) {
    _gstPercentage = gstPercentage;
    _gstPrice = (pretaxPrice! * _gstPercentage!) / 100;
    _afterTaxPrice = (_pretaxPrice! - (_pretaxPrice! * _gstPercentage!) / 100);
    notifyListeners();
  }

  void setPrepaidDiscountPercentage(double prepaidDiscountPercentage) {
    _prepaidDiscountPercentage = prepaidDiscountPercentage;
    _prepaidDiscountValue =
        ((_afterTaxPrice! * prepaidDiscount!) / 100).roundToDouble();
    setFinalPrice();
    notifyListeners();
  }

  void setFinalPrice() {
    _finalPriceWithoutPrepaidDiscount = _afterTaxPrice;
    _finalPrice = (_afterTaxPrice! - _prepaidDiscountValue!);
    notifyListeners();
  }
}
