import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import '../../models/nearby_places_model/nearby_places_model.dart';
import '../../models/nearby_places_model/place_category_model.dart';

class NearByPlacesTabView extends StatefulWidget {
  final NearbyPlacesModel nearbyPlacesModel;

  const NearByPlacesTabView({Key? key, required this.nearbyPlacesModel})
      : super(key: key);

  @override
  State<NearByPlacesTabView> createState() => _NearByPlacesTabViewState();
}

class _NearByPlacesTabViewState extends State<NearByPlacesTabView>
    with AutomaticKeepAliveClientMixin<NearByPlacesTabView> {
  @override
  bool get wantKeepAlive => true;

  Widget _buildPlaceListView(BuildContext context,
      Map<String, List<PlaceCategoryModel>> placesDetails) {
    List<PlaceCategoryModel> places = placesDetails.values.first;
    final LatLng fixedLocation = LatLng(
        widget.nearbyPlacesModel.hotelLocationDetails.lat,
        widget.nearbyPlacesModel.hotelLocationDetails.lng);
    final Geodesy geodesy = Geodesy();

    return ListView.builder(
      physics: const BouncingScrollPhysics(
        decelerationRate: ScrollDecelerationRate.normal,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemCount: places.length,
      itemBuilder: (context, index) {
        PlaceCategoryModel? place = places[index];
        num placeDistance = geodesy.distanceBetweenTwoGeoPoints(
          LatLng(fixedLocation.latitude, fixedLocation.longitude),
          LatLng(place.lat, place.lng),
        );
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (placesDetails.keys.first == "all")
                const Icon(Icons.location_pin),
              if (placesDetails.keys.first == "transport")
                const Icon(Icons.emoji_transportation),
              if (placesDetails.keys.first == "mallsAndRestaurants")
                const Icon(Icons.restaurant),
              if (placesDetails.keys.first == "popularPlaces")
                const Icon(Icons.place_outlined),
              const SizedBox(width: 30),
              // add some space between icon and text
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      place.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${(placeDistance / 1000).toStringAsFixed(2)} km',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Container(
        color: Colors.white, // Set the background color to white
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16), // A
            Center(
              child: Container(
                width: 20, // Customize the width of the indicator
                height: 2, // Customize the height of the indicator
                color: Colors.black, // Customize the color of the indicator
              ),
            ), // dd some extra space at the top
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: TabBar(
                isScrollable: true,
                indicatorColor: Colors.red.shade400,
                labelStyle: const TextStyle(fontSize: 13),
                // Set your desired text size
                tabs: const [
                  Tab(text: 'All'),
                  Tab(text: 'Transport'),
                  Tab(text: 'Malls & Restaurants'),
                  Tab(text: 'Popular Places'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPlaceListView(context, {
                    "all": [
                      ...widget.nearbyPlacesModel.transport,
                      ...widget.nearbyPlacesModel.mallsAndRestaurants,
                      ...widget.nearbyPlacesModel.popularPlaces,
                      ...widget.nearbyPlacesModel.others
                    ]
                  }),
                  _buildPlaceListView(context,
                      {"transport": widget.nearbyPlacesModel.transport}),
                  _buildPlaceListView(context, {
                    "mallsAndRestaurants":
                        widget.nearbyPlacesModel.mallsAndRestaurants
                  }),
                  _buildPlaceListView(context, {
                    "popularPlaces": widget.nearbyPlacesModel.popularPlaces
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
