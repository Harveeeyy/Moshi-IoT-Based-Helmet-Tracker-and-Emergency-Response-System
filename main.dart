import 'package:flutter/material.dart';
import 'maps_page.dart';

void main() {
  runApp(const MaterialApp(
    home: MyHelmetPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyHelmetPage extends StatefulWidget {
  const MyHelmetPage({super.key});

  @override
  State<MyHelmetPage> createState() => _MyHelmetPageState();
}

class _MyHelmetPageState extends State<MyHelmetPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String backgroundImage = 'lib/moshi/assets/images/bg.png';
  String coverPhoto = 'lib/moshi/assets/images/wall.png';
  String profileImage = 'lib/moshi/assets/images/profile.png';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

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

  void _navigateTo(String title) {
    Widget page;

    switch (title) {
      case "Maps":
        page = const MapsPage();
        break;
      case "SOS Message":
      case "Profile":
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
      backgroundColor: Colors.white,
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
                      child: Image.asset(
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
                    child: IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    top: 160,
                    left: MediaQuery.of(context).size.width / 2 - 40,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => _showZoomImage(profileImage),
                          child: Container(
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
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(profileImage),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {},
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
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  tabs: const [
                    Tab(child: Center(child: Text("My Helmet"))),
                    Tab(child: Center(child: Text("Tracker"))),
                    Tab(child: Center(child: Text("Contacts"))),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _myHelmetTab(),
                      _placeholderTab("Tracker"),
                      _placeholderTab("Contacts"),
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
        onTapMap: () => _navigateTo("Maps"),
        onTapSOS: () => _navigateTo("SOS Message"),
        onTapProfile: () => _navigateTo("Profile"),
        onTapLogout: () => _navigateTo("Logout"),
      ),
    );
  }

  Widget _myHelmetTab() {
    return Padding(
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Center(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 8),
                  shrinkWrap: true,
                  children: [
                    // Helmet Images
                    GestureDetector(
                      onTap: () => _showZoomImage('lib/moshi/assets/images/helmet1.jpg'),
                      child: helmetImage('lib/moshi/assets/images/helmet1.jpg'),
                    ),
                    GestureDetector(
                      onTap: () => _showZoomImage('lib/moshi/assets/images/helmet2.jpg'),
                      child: helmetImage('lib/moshi/assets/images/helmet2.jpg'),
                    ),
                    GestureDetector(
                      onTap: () => _showZoomImage('lib/moshi/assets/images/helmet3.jpg'),
                      child: helmetImage('lib/moshi/assets/images/helmet3.jpg'),
                    ),

                    // Upload Image Button
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Upload image tapped")),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.teal),
                        ),
                        child: const Center(
                          child: Icon(Icons.add_a_photo, color: Colors.teal, size: 30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            infoCard(
              title: "About my helmet",
              subtitle1: "Shox Sniper Solid",
              subtitle2: "Black",
              icon: const ImageIcon(
                AssetImage('lib/moshi/assets/icons/helmet2.png'),
                size: 32,
                color: Colors.teal,
              ),
              onEdit: () {},
            ),
            infoCard(
              title: "About my motorcycle",
              subtitle1: "Royal Enfield 650 Interceptor",
              subtitle2: "Black",
              icon: const ImageIcon(
                AssetImage('lib/moshi/assets/icons/motor2.png'),
                size: 32,
                color: Colors.teal,
              ),
              onEdit: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderTab(String label) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Center(
        child: Text(
          "$label content goes here",
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  Widget helmetImage(String path) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget infoCard({
    required String title,
    required String subtitle1,
    required String subtitle2,
    required Widget icon,
    required VoidCallback onEdit,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.verified_user, size: 16, color: Colors.teal),
                    const SizedBox(width: 6),
                    Text(subtitle1),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.palette, size: 16, color: Colors.teal),
                    const SizedBox(width: 6),
                    Text(subtitle2),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onEdit,
            child: Row(
              children: const [
                Text("Edit", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final String profileImage;
  final VoidCallback onTapMap;
  final VoidCallback onTapSOS;
  final VoidCallback onTapProfile;
  final VoidCallback onTapLogout;

  const BottomNavBar({
    super.key,
    required this.profileImage,
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
            backgroundImage: AssetImage(profileImage),
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
