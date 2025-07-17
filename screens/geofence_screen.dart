import 'package:flutter/material.dart';

class GeofenceScreen extends StatelessWidget {
  const GeofenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GEOFENCE')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('FEATURE', style: TextStyle(fontSize: 18)),
            TextFormField(decoration: const InputDecoration(labelText: 'Location Name')),
            // Add other geofence content
          ],
        ),
      ),
    );
  }
}