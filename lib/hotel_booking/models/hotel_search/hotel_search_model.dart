import 'package:json_annotation/json_annotation.dart';
import 'package:practise1/hotel_booking/models/star_ratings_model/star_ratings_average_model.dart';

import '../hotel_contact_details/hotel_contact_details.dart';
import '../nearby_places_model/place_category_model.dart';
import '../room_type_search_model/room_type_search_model.dart';

part 'hotel_search_model.g.dart'; // This file will be generated by build_runner

@JsonSerializable()
class HotelSearchModel {
  @JsonKey(name: 'hotelImages')
  List<String> hotelImages;

  @JsonKey(name: 'hotelLocationDetails')
  PlaceCategoryModel hotelLocationDetails;

  @JsonKey(name: 'highlights')
  List<String> highlights;

  @JsonKey(name: 'hotelId')
  String hotelId;

  @JsonKey(name: 'roomTypeForSearch')
  List<RoomTypeSearchModel> roomTypeForSearch;

  @JsonKey(name: 'ratings')
  StarRatingAverageModel starRatingAverageModel;

  @JsonKey(name: 'hotelContactDetails')
  HotelContactDetails hotelContactDetails;

  @JsonKey(name: 'cityAndState')
  String cityAndState;

  HotelSearchModel({
    required this.hotelImages,
    required this.hotelLocationDetails,
    required this.highlights,
    required this.hotelId,
    required this.roomTypeForSearch,
    required this.starRatingAverageModel,
    required this.hotelContactDetails,
    required this.cityAndState,
  });

  // Add the factory constructor for parsing from JSON
  factory HotelSearchModel.fromJson(Map<String, dynamic> json) =>
      _$HotelSearchModelFromJson(json);

  // Add the method for serialization to JSON
  Map<String, dynamic> toJson() => _$HotelSearchModelToJson(this);
}