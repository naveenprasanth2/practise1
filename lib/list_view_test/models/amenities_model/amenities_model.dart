import 'package:practise1/list_view_test/models/amenities_model/bed_type.dart';
import 'package:practise1/list_view_test/models/amenities_model/hotel_facilities.dart';
import 'package:practise1/list_view_test/models/amenities_model/media_technology.dart';
import 'package:practise1/list_view_test/models/amenities_model/room_facility.dart';
import 'package:practise1/list_view_test/models/amenities_model/seating_area.dart';
import 'package:practise1/list_view_test/models/amenities_model/washroom.dart';

class AmenitiesModel {
  BedTypeModel? bedTypeModel;
  HotelFacilitiesModel? hotelFacilitiesModel;
  MediaTechnologyModel? mediaTechnologyModel;
  RoomFacilityModel? roomFacilityModel;
  WashroomModel? washroomModel;
  SeatingAreaModel? seatingAreaModel;

  AmenitiesModel(
    this.bedTypeModel,
    this.hotelFacilitiesModel,
    this.mediaTechnologyModel,
    this.roomFacilityModel,
    this.washroomModel,
    this.seatingAreaModel,
  );

  AmenitiesModel.fromJson(Map<dynamic, dynamic> json) {
    bedTypeModel = BedTypeModel.fromJson(json["bedTypeModel"]);
    hotelFacilitiesModel =
        HotelFacilitiesModel.fromJson(json["hotelFacilitiesModel"]);
    mediaTechnologyModel =
        MediaTechnologyModel.fromJson(json["mediaTechnologyModel"]);
    roomFacilityModel = RoomFacilityModel.fromJson(json["roomFacilityModel"]);
    washroomModel = WashroomModel.fromJson(json["washroomModel"]);
    seatingAreaModel = SeatingAreaModel.fromJson(json["seatingAreaModel"]);
  }
}
