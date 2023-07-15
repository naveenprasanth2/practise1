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

  AmenitiesModel.fromJson(Map<String, dynamic> json) {
    bedTypeModel = json["bedTypeModel"];
    hotelFacilitiesModel = json["hotelFacilitiesModel"];
    mediaTechnologyModel = json["mediaTechnologyModel"];
    roomFacilityModel = json["roomFacilityModel"];
    washroomModel = json["washroomModel"];
    seatingAreaModel = json["seatingAreaModel"];
  }
}
