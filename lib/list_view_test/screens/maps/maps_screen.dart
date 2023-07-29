import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    requestLocationPermission();
    super.initState();
  }

  void requestLocationPermission() async {
    if (await Permission.location.isGranted) {
      // Either the permission was already granted before or the user just granted it.
    } else {
      Permission.location.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Maps Demo')),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),  // Set this to your desired coordinates
          zoom: 5,
        ),
      ),
    );
  }
}
