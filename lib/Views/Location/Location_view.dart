import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Utilis/Widgets/GeneralAppbar.dart';

class GoogleMapScreen extends StatefulWidget {
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(0, 0), // Initial dummy position
    zoom: 14.0,
  );

  final Set<Marker> _markers = {};
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _fetchLocationData();
  }

  void _fetchLocationData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('location')
        .doc('zarGijYH376VIwYqk4cE-location')
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      double lat = double.parse(data['lat']);
      double lon = double.parse(data['lon']);

      print("Latitude: $lat, Longitude: $lon"); // Debugging statement

      setState(() {
        _currentPosition = LatLng(lat, lon);
        _markers.add(
          Marker(
            markerId: MarkerId('current position'),
            position: _currentPosition,
            infoWindow: InfoWindow(
              title: 'Current Position',
            ),
          ),
        );

        print("Marker added at $_currentPosition"); // Debugging statement
      });

      _moveCameraToPosition(_currentPosition);
    } else {
      print("Document does not exist"); // Debugging statement
    }
  }

  void _moveCameraToPosition(LatLng position) {
    if (_mapController != null) {
      _mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 14.0),
      ));
    } else {
      print("Map controller is null"); // Debugging statement
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: 'Location'),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              mapType: MapType.hybrid,
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                if (_currentPosition.latitude != 0 && _currentPosition.longitude != 0) {
                  _moveCameraToPosition(_currentPosition);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
