import 'package:flutter/material.dart';
import 'package:practise1/list_view_test/models/nearby_places_model/nearby_places_model.dart';

import '../models/nearby_places_model/place_category_model.dart';

class MapProvider extends ChangeNotifier {
  late double clickedLat;
  late double clickedLng;
  late String clickedPlaceName;

  void setLatAndLng(NearbyPlacesModel nearbyPlacesModel) {
    PlaceCategoryModel nearbyPlaces = nearbyPlacesModel.hotelLocationDetails;
    clickedLat = nearbyPlaces.lat;
    clickedLng = nearbyPlaces.lng;
    clickedPlaceName = nearbyPlaces.name;
  }

  void setClickedLatAndLng(double latitude, double longitude, String placeName) {
    clickedLat = latitude;
    clickedLng = longitude;
    clickedPlaceName = placeName;
  }

}
