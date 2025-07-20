import 'package:flutter/material.dart';

class SOSPage extends StatelessWidget {
  const SOSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOS Page'),
        backgroundColor: Colors.redAccent,
      ),
      body: const Center(
        child: Text(
          'Emergency SOS Activated!',
          style: TextStyle(fontSize: 24, color: Colors.red),
        ),
      ),
    );
  }
}
