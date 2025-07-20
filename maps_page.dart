import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatelessWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Maps"), backgroundColor: Colors.teal),
      body: const GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(14.5995, 120.9842), // Example: Manila
          zoom: 12,
        ),
      ),
    );
  }
}
