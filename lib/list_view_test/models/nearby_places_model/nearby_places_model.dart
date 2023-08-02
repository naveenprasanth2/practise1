import 'package:json_annotation/json_annotation.dart';
import 'package:practise1/list_view_test/models/nearby_places_model/place_category_model.dart';

part 'nearby_places_model.g.dart';

@JsonSerializable()
class NearbyPlacesModel {
  @JsonKey(name: 'hotelLocationDetails')
  final PlaceCategoryModel hotelLocationDetails;
  @JsonKey(name: 'transport')
  final List<PlaceCategoryModel> transport;
  @JsonKey(name: 'mallsAndRestaurants')
  final List<PlaceCategoryModel> mallsAndRestaurants;
  @JsonKey(name: 'popularPlaces')
  final List<PlaceCategoryModel> popularPlaces;
  @JsonKey(name: 'others')
  final List<PlaceCategoryModel> others;

  NearbyPlacesModel({
    required this.hotelLocationDetails,
    required this.transport,
    required this.mallsAndRestaurants,
    required this.popularPlaces,
    required this.others,
  });

  factory NearbyPlacesModel.fromJson(Map<String, dynamic> json) =>
      _$NearbyPlacesModelFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyPlacesModelToJson(this);
}
