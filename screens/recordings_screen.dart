import 'package:flutter/material.dart';
import '../widgets/recording_item.dart';

class RecordingsScreen extends StatelessWidget {
  const RecordingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Recordings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          RecordingItem(fileName: 'Recording_1.m4a'),
          RecordingItem(fileName: 'Recording_2.m4a'),
          // Add other recordings
        ],
      ),
    );
  }
}