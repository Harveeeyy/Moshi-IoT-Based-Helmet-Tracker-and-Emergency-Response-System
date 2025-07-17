import 'package:flutter/material.dart';

class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Show Battery', style: TextStyle(fontSize: 18)),
          SwitchListTile(title: const Text('Network'), value: true, onChanged: (_) {}),
          // Add other tracker content
        ],
      ),
    );
  }
}