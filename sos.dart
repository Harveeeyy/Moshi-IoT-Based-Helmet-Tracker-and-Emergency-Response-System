import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';

void main() {
  runApp(const MaterialApp(
    home: MyHelmetPage(),
    debugShowCheckedModeBanner: false,
  ));
}


class SOSPage extends StatefulWidget {
  const SOSPage({super.key});

  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  String? _locationUrl;
  bool _loading = true;
  String _alertMessage =
      'Hello, my name is ___________. I am in immediate danger and need urgent medical assistance.\n\n'
      'Please send an ambulance to my current location:';

  final String backgroundImage = 'assets/images/bg.png';
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationUrl = 'Location services are disabled.';
        _loading = false;
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationUrl = 'Location permission denied.';
          _loading = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationUrl = 'Location permissions are permanently denied.';
        _loading = false;
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final url =
        'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

    setState(() {
      _locationUrl = url;
      _loading = false;
    });
  }

  void _launchMaps() async {
    if (_locationUrl != null &&
        await canLaunchUrl(Uri.parse(_locationUrl!))) {
      await launchUrl(Uri.parse(_locationUrl!),
          mode: LaunchMode.externalApplication);
    }
  }

  void _editMessage() {
    final controller = TextEditingController(text: _alertMessage);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Alert Message"),
        content: TextField(
          controller: controller,
          maxLines: 8,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
    ),
    onPressed: () => Navigator.pop(context),
    child: const Text(
      "Cancel",
      style: TextStyle(color: Colors.white),
    ),
  ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
    ),
    onPressed: () {
      setState(() {
                _alertMessage = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text(
      "Save",
      style: TextStyle(color: Colors.white),
    ),
  ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FC),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
            'SOS Message',
            style: TextStyle(color: Colors.white),
          ),

        leading: IconButton(
         icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(backgroundImage, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  icon: Icons.phone_in_talk,
                  title: 'Alert Message',
                ),
                const SizedBox(height: 12),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'EMERGENCY ALERT !!!',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _editMessage,
                                    child: Row(
                                      children: const [
                                        Text("Edit",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        Icon(Icons.arrow_forward_ios,
                                            size: 14, color: Colors.grey),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _alertMessage,
                                style: const TextStyle(
                                    fontSize: 15, height: 1.4),
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: _launchMaps,
                                child: Text(
                                  _locationUrl ?? 'Location unavailable',
                                  style: const TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Do not call back.\nPlease notify emergency responders immediately.',
                                style:
                                    TextStyle(fontSize: 15, height: 1.4),
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}
