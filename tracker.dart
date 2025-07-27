import 'package:flutter/material.dart';

class TrackerTab extends StatelessWidget {
  const TrackerTab({super.key});

  // Tracker Tab (Battery, Network (Wi-Fi), GPS Containers)
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(  // Use Column to ensure the Row stays at the top
        mainAxisAlignment: MainAxisAlignment.start,  // Align the Row at the top
        crossAxisAlignment: CrossAxisAlignment.start,  // Align Row to the left
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start, // Align the containers to the start (left)
            children: [
              Expanded(child: _statusContainer(Icons.battery_full, "Battery", Colors.teal, " 98%", 40, true)), // Rotated battery icon
              const SizedBox(width: 8),  // Reduced spacing between the containers
              Expanded(child: _statusContainer(Icons.wifi, "Network", Colors.teal, "Connected", 35, false)), // Wi-Fi icon for Network
              const SizedBox(width: 8),  // Reduced spacing between the containers
              Expanded(child: _statusContainer(Icons.location_on, "GPS", Colors.teal, "Connected", 35, false)), // Location icon, no rotation
            ],
          ),
        ],
      ),
    );
  }

  // Container for each status (Battery, Network (Wi-Fi), GPS)
  Widget _statusContainer(IconData icon, String label, Color color, String status, double iconSize, bool rotate) {
    return Container(
      height: 90,  // Height for the rectangular shape
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Rounded corners for rectangular look
        // No shadows now
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the text and icon
        children: [
          Align(
            alignment: Alignment.centerLeft,  // Align text to the left
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,  // Align to the left
            children: [
              // Apply rotation only to battery icon
              if (rotate) 
                Transform.rotate(
                  angle: 3.14159 / 2, // Rotate the icon 90 degrees (Pi/2 radians)
                  child: Icon(icon, size: iconSize, color: color),
                )
              else
                Icon(icon, size: iconSize, color: color), // No rotation for network and location icons
              if (status.isNotEmpty) ...[
                const SizedBox(width: 4),  // Small space between icon and percentage
                Center(  // Center-align the percentage
                  child: Text(
                    status,  // Display percentage next to the battery icon
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green, // Green color for the "98%" text
                    ),
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
