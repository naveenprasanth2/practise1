import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practise1/list_view_test/models/nearby_places_model/place_category_model.dart';
import '../../models/nearby_places_model/nearby_places_model.dart';
import '../../widgets/maps/maps_bottom_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Map<String, Marker> _markers = {};
  NearbyPlacesModel? nearbyPlaces;

  @override
  void initState() {
    super.initState();
    parseJsonToNearbyPlacesModel().then((value) => {
          setState(() {
            nearbyPlaces = value;
          }),
        });
  }

  Future<NearbyPlacesModel> parseJsonToNearbyPlacesModel() async {
    final jsonString = await rootBundle.loadString('assets/nearby_places.json');
    final jsonMap = json.decode(jsonString);
    final nearbyPlacesModel = NearbyPlacesModel.fromJson(jsonMap);
    return nearbyPlacesModel;
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    if (nearbyPlaces == null) return;

    final hotelIcon = await _createCustomMarkerIcon('assets/hotel_icon.jpeg');
    final othersIcon = await _createCustomMarkerIcon('assets/others_icon.jpeg');
    final transportIcon =
        await _createCustomMarkerIcon('assets/transport_icon.jpeg');
    final mallsRestaurantsIcon =
        await _createCustomMarkerIcon('assets/malls_restaurants_icon.jpeg');
    final popularPlacesIcon =
        await _createCustomMarkerIcon('assets/popular_places_icon.jpeg');

    setState(() {
      _markers.clear();
      _createMarkers(nearbyPlaces!, hotelIcon, othersIcon, transportIcon,
          mallsRestaurantsIcon, popularPlacesIcon);
    });
  }

  void _createMarkers(
      NearbyPlacesModel nearbyPlaces,
      BitmapDescriptor hotelIcon,
      BitmapDescriptor othersIcon,
      BitmapDescriptor transportIcon,
      BitmapDescriptor mallsRestaurantsIcon,
      BitmapDescriptor popularPlacesIcon) {
    final hotelMarker = Marker(
      markerId: MarkerId(nearbyPlaces.hotelLocationDetails.name),
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
    _markers['hotel'] = hotelMarker;

    _addMarkers(nearbyPlaces.transport, transportIcon);
    _addMarkers(nearbyPlaces.mallsAndRestaurants, mallsRestaurantsIcon);
    _addMarkers(nearbyPlaces.popularPlaces, popularPlacesIcon);
    _addMarkers(nearbyPlaces.others, othersIcon);
  }

  void _addMarkers(List<PlaceCategoryModel> places, BitmapDescriptor icon) {
    for (final place in places) {
      final marker = Marker(
        markerId: MarkerId(place.name),
        position: LatLng(place.lat, place.lng),
        icon: icon,
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.address,
        ),
      );
      _markers[place.name] = marker;
    }
  }

  Future<BitmapDescriptor> _createCustomMarkerIcon(String path) async {
    final byteData = await rootBundle.load(path);
    var codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List(),
        targetWidth: 100);
    var frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (nearbyPlaces == null)
              ? Container()
              : GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(nearbyPlaces!.hotelLocationDetails.lat,
                        nearbyPlaces!.hotelLocationDetails.lng),
                    zoom: 16,
                  ),
                  markers: _markers.values.toSet(),
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.2,
              maxChildSize: 0.6,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels != 0.0) {
                      return true;
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.6,
                      child: (nearbyPlaces != null)
                          ? NearByPlacesTabView(nearbyPlacesModel: nearbyPlaces!)
                          : const CircularProgressIndicator(),  // Replace this with an appropriate widget for when nearbyPlaces is null
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
