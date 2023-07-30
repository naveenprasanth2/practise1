import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';

import '../../models/nearby_places_model/office_model.dart';
import '../../models/nearby_places_model/offices_model.dart';

class OfficeTabView extends StatefulWidget {
  final Future<OfficesModel> futureOffices;

  const OfficeTabView({required this.futureOffices, Key? key})
      : super(key: key);

  @override
  State<OfficeTabView> createState() => _OfficeTabViewState();
}

class _OfficeTabViewState extends State<OfficeTabView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget _buildOfficeListView(BuildContext context) {
    final LatLng fixedLocation = LatLng(37.4219999, -122.0840575);
    final Geodesy geodesy = Geodesy();

    return FutureBuilder<OfficesModel>(
      future: widget.futureOffices,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.normal,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            itemCount: snapshot.data?.offices.length,
            itemBuilder: (context, index) {
              OfficeModel? office = snapshot.data?.offices[index];
              num officeDistance = geodesy.distanceBetweenTwoGeoPoints(
                LatLng(fixedLocation.latitude, fixedLocation.longitude),
                LatLng(office!.lat, office.lng),
              );
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(width: 30),
                    // add some space between icon and text
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            office.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${(officeDistance / 1000).toStringAsFixed(2)} km',
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
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
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
            ),// dd some extra space at the top
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
                  _buildOfficeListView(context),
                  _buildOfficeListView(context),
                  _buildOfficeListView(context),
                  _buildOfficeListView(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
