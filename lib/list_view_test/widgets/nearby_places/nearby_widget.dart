import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
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

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Nearby Places",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            DefaultTabController(
              length: 4,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.red.shade400,
                      labelStyle: const TextStyle(fontSize: 13),
                      physics: const BouncingScrollPhysics(),
                      indicatorPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                      tabs: const [
                        Tab(text: 'Transport'),
                        Tab(text: 'Malls & Restaurants'),
                        Tab(text: 'Popular Places'),
                        Tab(text: 'Others'),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.3, // Set a specific height here
                      child: TabBarView(
                        children: [
                          _buildPlaceListView(context,
                              {"transport": widget.nearbyPlacesModel.transport}),
                          _buildPlaceListView(context, {
                            "mallsAndRestaurants":
                                widget.nearbyPlacesModel.mallsAndRestaurants
                          }),
                          _buildPlaceListView(context, {
                            "popularPlaces":
                                widget.nearbyPlacesModel.popularPlaces
                          }),
                          _buildPlaceListView(context,
                              {"others": widget.nearbyPlacesModel.others}),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
