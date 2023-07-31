import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as map_launcher;
import 'package:practise1/list_view_test/models/nearby_places_model/place_category_model.dart';
import 'package:practise1/list_view_test/providers/maps_provider.dart';
import 'package:provider/provider.dart';
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
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _loadNearbyPlaces();
  }

  Future<void> _loadNearbyPlaces() async {
    final jsonString = await rootBundle.loadString('assets/nearby_places.json');
    final jsonMap = json.decode(jsonString);
    final nearbyPlacesModel = NearbyPlacesModel.fromJson(jsonMap);
    setState(() {
      nearbyPlaces = nearbyPlacesModel;
    });
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    Provider.of<MapProvider>(context, listen: false)
        .setLatAndLng(nearbyPlaces!);
    _addMarkers();
  }

  void _addMarkers() async {
    if (nearbyPlaces == null || mapController == null) return;

    final hotelIcon =
        await _createCustomMarkerIconForMainPlace('assets/hotel_icon.png');
    final othersIcon = await _createCustomMarkerIcon('assets/others_icon.png');
    final transportIcon =
        await _createCustomMarkerIcon('assets/transport_icon.png');
    final mallsRestaurantsIcon =
        await _createCustomMarkerIcon('assets/malls_restaurants_icon.png');
    final popularPlacesIcon =
        await _createCustomMarkerIcon('assets/popular_places_icon.png');

    final hotelMarker = Marker(
      markerId: MarkerId(nearbyPlaces!.hotelLocationDetails.name),
      onTap: () {
        Provider.of<MapProvider>(context, listen: false).setClickedLatAndLng(
            nearbyPlaces!.hotelLocationDetails.lat,
            nearbyPlaces!.hotelLocationDetails.lng,
            nearbyPlaces!.hotelLocationDetails.name);
      },
      icon: hotelIcon,
      position: LatLng(
        nearbyPlaces!.hotelLocationDetails.lat,
        nearbyPlaces!.hotelLocationDetails.lng,
      ),
      infoWindow: InfoWindow(
        title: nearbyPlaces!.hotelLocationDetails.name,
        snippet: nearbyPlaces!.hotelLocationDetails.address,
      ),
    );
    _markers['hotel'] = hotelMarker;

    _addCategoryMarkers(nearbyPlaces!.transport, transportIcon);
    _addCategoryMarkers(
        nearbyPlaces!.mallsAndRestaurants, mallsRestaurantsIcon);
    _addCategoryMarkers(nearbyPlaces!.popularPlaces, popularPlacesIcon);
    _addCategoryMarkers(nearbyPlaces!.others, othersIcon);

    setState(() {}); // To trigger marker addition on the map
  }

  void _addCategoryMarkers(
      List<PlaceCategoryModel> places, BitmapDescriptor icon) {
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
      _markers[place.name] = marker;
    }
  }

  void _openMap() async {
    await map_launcher.MapLauncher.installedMaps.then(
      (availableMaps) => {
        if (availableMaps.isNotEmpty)
          {
            availableMaps[0].showMarker(
              coords: map_launcher.Coords(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapProvider>(builder: (context, provider, _) {
        return Stack(
          children: [
            (nearbyPlaces == null)
                ? Container()
                : GoogleMap(
                    onMapCreated: _onMapCreated,
                    myLocationButtonEnabled: false,
                    mapType: MapType.terrain,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        nearbyPlaces!.hotelLocationDetails.lat,
                        nearbyPlaces!.hotelLocationDetails.lng,
                      ),
                      zoom: 16,
                    ),
                    markers: _markers.values.toSet(),
                  ),
            Positioned(
              top: 50,
              left: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              right: 10,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: FloatingActionButton(
                  onPressed: () {
                    _openMap();
                  },
                  backgroundColor: Colors.red.shade400,
                  child: const Icon(
                    Icons.directions,
                    color: Colors.white,
                  ),
                ),
              ),
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
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: (nearbyPlaces != null && mapController != null)
                            ? NearByPlacesTabView(
                                nearbyPlacesModel: nearbyPlaces!,
                                googleMapController: mapController!)
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
