import 'package:flutter/material.dart';

class RecordingItem extends StatelessWidget {
  final String fileName;

  const RecordingItem({super.key, required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.audiotrack),
        title: Text(fileName),
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow),
          onPressed: () {},
        ),
      ),
    );
  }
}