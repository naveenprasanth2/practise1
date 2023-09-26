import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:practise1/hotel_booking/providers/maps_provider.dart';
import 'package:practise1/hotel_booking/utils/common_helper/general_utils.dart';
import 'package:provider/provider.dart';
import '../../models/nearby_places_model/nearby_places_model.dart';
import '../../widgets/maps/maps_bottom_widget.dart';

class MapScreen extends StatefulWidget {
  final NearbyPlacesModel nearbyPlacesModel;
  const MapScreen({Key? key, required this.nearbyPlacesModel})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  NearbyPlacesModel? nearbyPlaces;
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    _loadNearbyPlaces();
  }

  Future<void> _loadNearbyPlaces() async {
    setState(() {
      nearbyPlaces = widget.nearbyPlacesModel;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    MapProvider mapProvider = Provider.of<MapProvider>(context, listen: false);
    mapController = controller;
    mapProvider.setLatAndLng(nearbyPlaces!);
    mapProvider.addMarkers(nearbyPlaces!, mapController!, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MapProvider>(builder: (
        context,
        mapProvider,
        _,
      ) {
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
                    markers: mapProvider.markers.values.toSet(),
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
              child: FloatingActionButton(
                heroTag: "open map button",
                onPressed: () {
                  mapProvider.openMap(context);
                },
                backgroundColor: Colors.red.shade400,
                child: const Icon(
                  Icons.directions,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 300,
              right: 10,
              child: FloatingActionButton(
                heroTag: "copy button",
                onPressed: () {
                  GeneralUtils.copyAddressToClipboard(
                      context, mapProvider.clickedAddress);
                },
                backgroundColor: Colors.grey.shade400,
                child: const Icon(
                  Icons.file_copy_outlined,
                  color: Colors.white,
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
