import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:practise1/list_view_test/models/nearby_places_model/nearby_places_model.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import '../models/nearby_places_model/place_category_model.dart';

class MapProvider extends ChangeNotifier {
  final Map<String, Marker> markers = {};
  late double clickedLat;
  late double clickedLng;
  late String clickedPlaceName;

  void setLatAndLng(NearbyPlacesModel nearbyPlacesModel) {
    PlaceCategoryModel nearbyPlaces = nearbyPlacesModel.hotelLocationDetails;
    clickedLat = nearbyPlaces.lat;
    clickedLng = nearbyPlaces.lng;
    clickedPlaceName = nearbyPlaces.name;
  }

  void setClickedLatAndLng(
      double latitude, double longitude, String placeName) {
    clickedLat = latitude;
    clickedLng = longitude;
    clickedPlaceName = placeName;
  }

  void addCategoryMarkers(List<PlaceCategoryModel> places,
      BitmapDescriptor icon, BuildContext context) {
    for (final place in places) {
      final marker = Marker(
        markerId: MarkerId(place.name),
        onTap: () {
          Provider.of<MapProvider>(context, listen: false)
              .setClickedLatAndLng(place.lat, place.lng, place.name);
        },
        position: LatLng(place.lat, place.lng),
        icon: icon,
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.address,
        ),
      );
      markers[place.name] = marker;
    }
  }

  void addMarkers(NearbyPlacesModel nearbyPlaces,
      GoogleMapController mapController, BuildContext context) async {
    final hotelIcon =
        await _createCustomMarkerIconForMainPlace('assets/hotel_icon.png');
    await _createCustomMarkerIcon('assets/others_icon.png').then((othersIcon) =>
        addCategoryMarkers(nearbyPlaces.others, othersIcon, context));
    await _createCustomMarkerIcon('assets/transport_icon.png').then(
        (transportIcon) =>
            addCategoryMarkers(nearbyPlaces.transport, transportIcon, context));
    await _createCustomMarkerIcon('assets/malls_restaurants_icon.png').then(
        (mallsRestaurantsIcon) => addCategoryMarkers(
            nearbyPlaces.mallsAndRestaurants, mallsRestaurantsIcon, context));
    await _createCustomMarkerIcon('assets/popular_places_icon.png').then(
        (popularPlacesIcon) => addCategoryMarkers(
            nearbyPlaces.popularPlaces, popularPlacesIcon, context));

    final hotelMarker = Marker(
      markerId: MarkerId(nearbyPlaces.hotelLocationDetails.name),
      onTap: () {
        setClickedLatAndLng(
            nearbyPlaces.hotelLocationDetails.lat,
            nearbyPlaces.hotelLocationDetails.lng,
            nearbyPlaces.hotelLocationDetails.name);
      },
      icon: hotelIcon,
      position: LatLng(
        nearbyPlaces.hotelLocationDetails.lat,
        nearbyPlaces.hotelLocationDetails.lng,
      ),
      infoWindow: InfoWindow(
        title: nearbyPlaces.hotelLocationDetails.name,
        snippet: nearbyPlaces.hotelLocationDetails.address,
      ),
    );
    markers['hotel'] = hotelMarker;
    notifyListeners();
  }

  Future<BitmapDescriptor> _createCustomMarkerIcon(String path) async {
    final byteData = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List(),
        targetWidth: 120);
    var frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  Future<BitmapDescriptor> _createCustomMarkerIconForMainPlace(
      String path) async {
    final byteData = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List(),
        targetWidth: 170);
    var frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  void openMap(BuildContext context) async {
    await MapLauncher.installedMaps.then(
      (availableMaps) => {
        if (availableMaps.isNotEmpty)
          {
            availableMaps[0].showMarker(
              coords: Coords(
                  Provider.of<MapProvider>(context, listen: false).clickedLat,
                  Provider.of<MapProvider>(context, listen: false).clickedLng),
              title: Provider.of<MapProvider>(context, listen: false)
                  .clickedPlaceName,
            ),
          }
        else
          {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('No Maps Apps Installed'),
                  content: const Text('Please install a maps app to navigate.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            ),
          },
      },
    );
  }
}
