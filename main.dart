import 'package:flutter/material.dart';
import 'screens/command_hub_screen.dart';

void main() {
  runApp(const MoshiApp());
}

class MoshiApp extends StatelessWidget {
  const MoshiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOSHI 2025',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CommandHubScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}