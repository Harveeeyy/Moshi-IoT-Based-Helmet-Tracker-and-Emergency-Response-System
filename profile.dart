import 'package:flutter/material.dart';
import 'userprofile.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Settings',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Arial',
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final File? profileImageFile; // ✅ Add this

  const ProfilePage({super.key, this.profileImageFile}); // ✅ Include in constructor

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage> {
  bool isNotificationOn = true;

  // ✅ Dynamic profile state
  String displayName = 'Mingsy';
  String? profileImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // ✅ Profile Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: widget.profileImageFile != null
                        ? FileImage(widget.profileImageFile!)
                        : const NetworkImage('assets/images/profile.png')
                            as ImageProvider,
                  ),

                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        displayName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.teal),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ✅ Working User Profile navigation
            buildSettingsTile(Icons.person_outline, 'User Profile', () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(
                    displayName: displayName,
                    imagePath: profileImagePath,
                  ),
                ),
              );

              if (result != null && mounted) {
                setState(() {
                  displayName = result['name'];
                  profileImagePath = result['imagePath'];
                });
              }
            }),

            buildSettingsTile(Icons.lock_outline, 'Change Password', () {}),

            // ✅ Push Notification Toggle
            ListTile(
              leading: const Icon(Icons.notifications_outlined, color: Colors.teal),
              title: const Text('Push Notification'),
              trailing: Switch(
                value: isNotificationOn,
                onChanged: (val) {
                  setState(() {
                    isNotificationOn = val;
                  });
                },
                activeColor: Colors.teal,
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

Widget buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: Colors.teal),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
    onTap: onTap,
  );
}
}