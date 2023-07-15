import 'package:practise1/list_view_test/models/amenities_model/bed_type.dart';
import 'package:practise1/list_view_test/models/amenities_model/hotel_facilities.dart';
import 'package:practise1/list_view_test/models/amenities_model/media_technology.dart';
import 'package:practise1/list_view_test/models/amenities_model/room_facility.dart';
import 'package:practise1/list_view_test/models/amenities_model/seating_area.dart';
import 'package:practise1/list_view_test/models/amenities_model/washroom.dart';

class AmenitiesModel {
  final BedTypeModel bedTypeModel;
  final HotelFacilitiesModel hotelFacilitiesModel;
  final MediaTechnologyModel mediaTechnologyModel;
  final RoomFacilityModel roomFacilityModel;
  final WashroomModel washroomModel;
  final SeatingAreaModel seatingAreaModel;

  AmenitiesModel({
    required this.bedTypeModel,
    required this.hotelFacilitiesModel,
    required this.mediaTechnologyModel,
    required this.roomFacilityModel,
    required this.washroomModel,
    required this.seatingAreaModel,
  });
}
