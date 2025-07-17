import 'package:flutter/material.dart';
import 'tracker_screen.dart';
import 'recordings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PROFILE'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Profile'),
            Tab(text: 'Tracker'),
            Tab(text: 'Recordings'),
          ]),
        ),
        body: const TabBarView(children: [
          _ProfileTab(),
          TrackerScreen(),
          RecordingsScreen(),
        ]),
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Change Cover photo', style: TextStyle(fontSize: 18)),
          // Add other profile content
        ],
      ),
    );
  }
}