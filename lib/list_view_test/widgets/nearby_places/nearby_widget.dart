import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:practise1/list_view_test/screens/maps/maps_screen.dart';
import '../../models/nearby_places_model/nearby_places_model.dart';
import '../../models/nearby_places_model/place_category_model.dart';

class NearByTabView extends StatefulWidget {
  final NearbyPlacesModel nearbyPlacesModel;

  const NearByTabView({
    Key? key,
    required this.nearbyPlacesModel,
  }) : super(key: key);

  @override
  State<NearByTabView> createState() => _NearByTabViewState();
}

class _NearByTabViewState extends State<NearByTabView>
    with AutomaticKeepAliveClientMixin<NearByTabView> {
  @override
  bool get wantKeepAlive => true;

  Widget _buildPlaceListView(BuildContext context,
      Map<String, List<PlaceCategoryModel>> placesDetails) {
    List<PlaceCategoryModel> places = placesDetails.values.first;
    final LatLng fixedLocation = LatLng(
      widget.nearbyPlacesModel.hotelLocationDetails.lat,
      widget.nearbyPlacesModel.hotelLocationDetails.lng,
    );
    final Geodesy geodesy = Geodesy();

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: List.generate(places.length, (index) {
          PlaceCategoryModel? place = places[index];
          num placeDistance = geodesy.distanceBetweenTwoGeoPoints(
            LatLng(fixedLocation.latitude, fixedLocation.longitude),
            LatLng(place.lat, place.lng),
          );

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (placesDetails.keys.first == "others")
                  const Icon(Icons.location_pin),
                if (placesDetails.keys.first == "transport")
                  const Icon(Icons.emoji_transportation),
                if (placesDetails.keys.first == "mallsAndRestaurants")
                  const Icon(Icons.restaurant),
                if (placesDetails.keys.first == "popularPlaces")
                  const Icon(Icons.place_outlined),
                const SizedBox(width: 30),
                // add some space between icon and text
                Flexible(
                  fit: FlexFit.loose,
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
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nearby Places",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 20,),
            DefaultTabController(
              length: 4,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.zero,
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: Colors.red.shade400,
                        labelStyle: const TextStyle(fontSize: 13),
                        labelPadding: const EdgeInsets.only(right: 24.0),
                        physics: const BouncingScrollPhysics(),
                        tabs: const [
                          Tab(text: 'Transport'),
                          Tab(text: 'Malls & Restaurants'),
                          Tab(text: 'Popular Places'),
                          Tab(text: 'Others'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250, // Set a specific height here
                      child: TabBarView(
                        children: [
                          _buildPlaceListView(
                            context,
                            {"transport": widget.nearbyPlacesModel.transport},
                          ),
                          _buildPlaceListView(
                            context,
                            {
                              "mallsAndRestaurants":
                                  widget.nearbyPlacesModel.mallsAndRestaurants
                            },
                          ),
                          _buildPlaceListView(
                            context,
                            {
                              "popularPlaces":
                                  widget.nearbyPlacesModel.popularPlaces
                            },
                          ),
                          _buildPlaceListView(
                            context,
                            {"others": widget.nearbyPlacesModel.others},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => const MapScreen()));
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text("View on Map"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
