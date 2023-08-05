import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/room_occupancy/room_model.dart';

class CalculationProvider extends ChangeNotifier {
  double? _costPerNight;
  double? _totalCostPerNight;
  double? _discountPercentage;
  double? _discountedPrice;
  double? _pretaxPrice;
  double? _gstPercentage;
  double? _gstPriceWithPrepaidDiscount;
  double? _gstPriceWithoutPrepaidDiscount;
  double? _afterTaxPriceWithPrepaidDiscount;
  double? _afterTaxPriceWithoutPrepaidDiscount;
  double? _prepaidDiscountPercentage;
  double? _prepaidDiscountValue;
  double? _finalPriceWithoutPrepaidDiscount;
  double? _finalPriceWithPrepaidDiscount;
  double? _totalAmount;
  int? _noOfDays;
  List<RoomModel> _roomsInfo = [RoomModel(adults: 1, children: 0)];

  double? get costPerNight => _costPerNight;

  double? get totalCostPerNight => _totalCostPerNight;

  double? get discountPercentage => _discountPercentage;

  double? get discountedPrice => _discountedPrice;

  double? get pretaxPrice => _pretaxPrice;

  double? get gstPercentage => _gstPercentage;

  double? get gstPriceWithPrepaidDiscount => _gstPriceWithPrepaidDiscount;

  double? get afterTaxPriceWithPrepaidDiscount =>
      _afterTaxPriceWithPrepaidDiscount;

  double? get afterTaxPriceWithoutPrepaidDiscount =>
      _afterTaxPriceWithoutPrepaidDiscount;

  double? get prepaidDiscount => _prepaidDiscountPercentage;

  double? get prepaidDiscountValue => _prepaidDiscountValue;

  double? get finalPriceWithoutPrepaidDiscount =>
      _finalPriceWithoutPrepaidDiscount;

  double? get finalPriceWithPrepaidDiscount => _finalPriceWithPrepaidDiscount;

  double? get totalAmount => _totalAmount;

  double? get gstPriceWithoutPrepaidDiscount => _gstPriceWithoutPrepaidDiscount;

  List<RoomModel> get roomsInfo => _roomsInfo;

  int? get noOfDays => _noOfDays;

  void setRoomsInfo(List<RoomModel> rooms) {
    _roomsInfo = rooms;
    setTotalCostPerNight();
    setDiscountValueAfterPriceReset();
    setPreTaxPrice();
    setPrepaidDiscountValue();
    setAfterTaxPrice();
    setFinalPrice();
    getNumberOfRooms();
    getNumberOfGuests();
    notifyListeners();
  }

  void setDateProviderData(int noOfDays) {
    _noOfDays = noOfDays;
    if(_costPerNight!=null){
      setTotalCostPerNight();
      setDiscountValueAfterPriceReset();
      setPreTaxPrice();
      setPrepaidDiscountValue();
      setAfterTaxPrice();
      setFinalPrice();
      getNumberOfRooms();
      getNumberOfGuests();
    }
    notifyListeners();
  }

  int getNumberOfRooms() {
    return _roomsInfo.length;
  }

  int getNumberOfGuests() {
    return _roomsInfo
        .map((roomGuests) => roomGuests.adults + roomGuests.children)
        .fold(0, (previousValue, element) => previousValue + element);
  }

  void setCostPerNight(int costPerNight) {
    //1. set the cost per night first
    _costPerNight = costPerNight.toDouble();
    notifyListeners();
  }

  void setTotalCostPerNight() {
    //2. set the total cost per night
    _totalCostPerNight = _roomsInfo.length * _costPerNight! * noOfDays!;
    double otherCost = _roomsInfo
        .where((element) => element.adults > 1)
        .map((e) => (e.adults - 1) * (.10 * _costPerNight!))
        .fold(0, (previousValue, element) => previousValue + element);
    _totalCostPerNight = (_totalCostPerNight! + otherCost);
    notifyListeners();
  }

  void setDiscountPercentage(int discountPercentage) {
    //3. set discount percentage next, as GST cannot be calculated without this
    setTotalCostPerNight();
    _discountPercentage = discountPercentage.toDouble();
    _discountedPrice = (totalCostPerNight! * discountPercentage) / 100;
    setPreTaxPrice();
    notifyListeners();
  }

  void setDiscountValueAfterPriceReset() {
    //3. set discount percentage next, as GST cannot be calculated without this
    setTotalCostPerNight();
    _discountedPrice = (totalCostPerNight! * discountPercentage!) / 100;
    setPreTaxPrice();
    notifyListeners();
  }

  void setPreTaxPrice() {
    //4. cost per night minus gives the pretax cost
    _pretaxPrice = (totalCostPerNight! - discountedPrice!);
    notifyListeners();
  }

  void setPrepaidDiscountPercentage(double prepaidDiscountPercentage) {
    //5. Calculate the prepaid discount value before GST as it may change with final price
    _prepaidDiscountPercentage = prepaidDiscountPercentage;
    setPrepaidDiscountValue();
    notifyListeners();
  }

  void setPrepaidDiscountValue() {
    //6. Calculate the total prepaid discount value
    _prepaidDiscountValue =
        ((_pretaxPrice! * prepaidDiscount!) / 100).roundToDouble();
    setAfterTaxPrice();
    setFinalPrice();
    notifyListeners();
  }

  void setGstPercentage(double gstPercentage) {
    //7. GST is now given as per the rules ( as per the _pretax price )
    if (costPerNight! < 4000) {
      _gstPercentage = gstPercentage;
    } else {
      _gstPercentage = 18;
    }

    notifyListeners();
  }

  void setAfterTaxPrice() {
    //7. After tax price should be calculated in 2 ways as there are two values to handle discounts
    _gstPriceWithPrepaidDiscount =
        ((_pretaxPrice! - _prepaidDiscountValue!) * _gstPercentage!) / 100;
    _gstPriceWithoutPrepaidDiscount = (_pretaxPrice! * _gstPercentage!) / 100;
    _afterTaxPriceWithPrepaidDiscount =
        (_pretaxPrice! + _gstPriceWithPrepaidDiscount!);
    _afterTaxPriceWithoutPrepaidDiscount =
        (_pretaxPrice! + _gstPriceWithoutPrepaidDiscount!);
    notifyListeners();
  }

  void setFinalPrice() {
    //8. final value is again calculated for prepaid discount and non prepaid discount.
    // final price and after tax values are same here.
    _finalPriceWithoutPrepaidDiscount = _afterTaxPriceWithoutPrepaidDiscount;
    _finalPriceWithPrepaidDiscount =
        (_afterTaxPriceWithPrepaidDiscount! - _prepaidDiscountValue!);
    notifyListeners();
  }

  void setDiscounts(int discountPercentage) {
    setDiscountPercentage(discountPercentage);
    setPreTaxPrice();
    setPrepaidDiscountValue();
    setAfterTaxPrice();
    setFinalPrice();
    notifyListeners();
  }

  void resetDiscounts() {
    setDiscountPercentage(0);
    setPreTaxPrice();
    setPrepaidDiscountValue();
    setAfterTaxPrice();
    setFinalPrice();
    notifyListeners();
  }
}
