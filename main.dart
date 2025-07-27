import 'package:flutter/material.dart';
import 'maps.dart';
import 'tracker.dart';  
import 'helmet.dart'; 
import 'contacts.dart';  
import 'sos.dart';
import 'profile.dart'; 
//import 'login.dart';

import 'package:flutter/foundation.dart'; // for kIsWeb
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// Commenting out Firebase temporarily
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: FirebaseAuth.instance.currentUser == null
    //     ? const AuthPage()
    //     : const MyHelmetPage(),
    home: const MyHelmetPage(),
    routes: {
      '/main': (context) => const MyHelmetPage(),
    }
  ));
}


class MyHelmetPage extends StatefulWidget {
  const MyHelmetPage({super.key});

  @override
  State<MyHelmetPage> createState() => _MyHelmetPageState();
}

class _MyHelmetPageState extends State<MyHelmetPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String backgroundImage = 'assets/images/bg.png';
  String coverPhoto = 'assets/images/wall.png';
  String profileImage = 'assets/images/profile.png';

File? _selectedImage;
Uint8List? _webImage;

File? _coverImage;
Uint8List? _webCoverImage;




Future<void> _pickProfileImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    if (kIsWeb) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _webImage = bytes;
      });
    } else {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}


Future<void> _pickCoverImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    if (kIsWeb) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _webCoverImage = bytes;
      });
    } else {
      setState(() {
        _coverImage = File(pickedFile.path);
      });
    }
  }
}





  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // Method to show the zoomed-in image
  void _showZoomImage(String path) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.black,
            child: InteractiveViewer(
              child: Image.asset(path),
            ),
          ),
        ),
      ),
    );
  }

  // Navigate to different pages based on title
  void _navigateTo(String title) {
    Widget page;

    switch (title) {
      case "Maps":
        page = const MapsPage();
        break;
      case "SOS Message":
        page = const SOSPage();
        break;
      case "Profile":
        page = ProfilePage(profileImageFile: _selectedImage);
      break;
      case "Logout":
      default:
        page = Scaffold(
          appBar: AppBar(title: Text(title), backgroundColor: Colors.teal),
          body: Center(child: Text("This is the $title page")),
        );
        break;
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FC),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [

                  GestureDetector(
  onTap: () => _showZoomImage(coverPhoto),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: _webCoverImage != null
        ? Image.memory(
            _webCoverImage!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        : _coverImage != null
            ? Image.file(
                _coverImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Image.asset(
                coverPhoto,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
  ),
),

Positioned(
  top: 10,
  right: 10,
  child: GestureDetector(
    onTap: _pickCoverImage,
    child: CircleAvatar(
      radius: 16,
      backgroundColor: Colors.white,
      child: Icon(Icons.camera_alt, size: 18, color: Colors.teal),
    ),
  ),
),


Positioned(
  top: 160,
  left: MediaQuery.of(context).size.width / 2 - 40,
  child: Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      // Outer decoration circle
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (_selectedImage != null) {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: Colors.black,
                      child: InteractiveViewer(
                        child: Image.file(_selectedImage!),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              _showZoomImage(profileImage);
            }
          },
          child: CircleAvatar(
            radius: 40,
            backgroundImage: _webImage != null
                ? MemoryImage(_webImage!)
                : _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : AssetImage(profileImage) as ImageProvider,
          ),
        ),
      ),

      // ✅ Camera icon on the top-left
      Positioned(
        top: 0,
      right: 0,
        child: GestureDetector(
          onTap: _pickProfileImage,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white,
            child: Icon(Icons.camera_alt, size: 16, color: Colors.teal),
          ),
        ),
      ),
    ],
  ),
),


                ],
              ),
              const SizedBox(height: 60),
              const Text(
                "Hi, Mingsy",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 15),

              //tab bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FC),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.teal),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.teal,
                  labelPadding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      child: Center(
                        child: Text(
                          "My Helmet",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          "Tracker",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Tab(
                      child: Center(
                        child: Text(
                          "Contacts",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 0),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      HelmetTab(), // Replace with the actual HelmetTab widget
                      TrackerTab(), // Replace with the actual TrackerTab widget
                      ContactsTab(), // The ContactsTab widget
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
  profileImage: profileImage,
  selectedImage: _selectedImage, // Pass this
  onTapMap: () => _navigateTo("Maps"),
  onTapSOS: () => _navigateTo("SOS Message"),
  onTapProfile: () => _navigateTo("Profile"),
  onTapLogout: () => _navigateTo("Logout"),
),

    );
  }
}

class BottomNavBar extends StatelessWidget {
  final String profileImage;
  final File? selectedImage; // Add this
  final VoidCallback onTapMap;
  final VoidCallback onTapSOS;
  final VoidCallback onTapProfile;
  final VoidCallback onTapLogout;

  const BottomNavBar({
    super.key,
    required this.profileImage,
    required this.selectedImage, // Add this
    required this.onTapMap,
    required this.onTapSOS,
    required this.onTapProfile,
    required this.onTapLogout,
  });


  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: onTapMap,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.map, color: Colors.black),
                Text("Maps", style: TextStyle(fontSize: 12))
              ],
            ),
          ),
          GestureDetector(
            onTap: onTapSOS,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.message, color: Colors.black),
                Text("SOS Message", style: TextStyle(fontSize: 12))
              ],
            ),
          ),
          CircleAvatar(
                    radius: 24,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : AssetImage(profileImage) as ImageProvider,
                  ),

          GestureDetector(
            onTap: onTapProfile,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, color: Colors.teal),
                Text("Profile", style: TextStyle(fontSize: 12))
              ],
            ),
          ),
          GestureDetector(
            onTap: onTapLogout,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout, color: Colors.black),
                Text("Logout", style: TextStyle(fontSize: 12))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
