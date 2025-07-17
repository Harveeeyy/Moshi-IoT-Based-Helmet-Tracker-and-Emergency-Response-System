import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'tracker_screen.dart';
import 'recordings_screen.dart';
import '../widgets/feature_button.dart';


class CommandHubScreen extends StatelessWidget {
  const CommandHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hi, Kit')),
      drawer: _buildDrawer(context),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          FeatureButton(
            icon: Icons.gps_fixed,
            label: 'Tracker',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TrackerScreen())),
          ),
          FeatureButton(
            icon: Icons.mic,
            label: 'Recordings',
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RecordingsScreen())),
          ),
          // Add other feature buttons
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text('MOSHI 2025')),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pop(context),
          ),
          // Add other drawer items
        ],
      ),
    );
  }
}