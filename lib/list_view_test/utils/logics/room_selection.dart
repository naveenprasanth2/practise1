import 'package:practise1/list_view_test/models/hotel_detail_model/room_type_model.dart';

class RoomSelection {
  String? _roomType;
  int _maxPeopleAllowed = 1;
  double? _price;
  RoomTypeModel? roomTypeModel;

  String get roomType => _roomType!;

  int get maxPeopleAllowed => _maxPeopleAllowed;

  double get price => _price!;

  void setRoomType(RoomTypeModel roomTypeModel) {
    this.roomTypeModel = roomTypeModel;
    _roomType = roomTypeModel.type;
    _maxPeopleAllowed = roomTypeModel.maxPeopleAllowed;
    _price = roomTypeModel.roomPrice;
  }
}
