import 'package:flutter/material.dart';
import 'dart:io';


class UserProfilePage extends StatefulWidget {
  final String displayName;
  final String? imagePath;

  const UserProfilePage({
    super.key,
    required this.displayName,
    this.imagePath,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController firstName = TextEditingController(text: 'Mingsy');
  final TextEditingController lastName = TextEditingController(text: '');
  final TextEditingController nickname = TextEditingController(text: '');
  final TextEditingController email = TextEditingController(text: 'mingsy@gmail.com');
  final TextEditingController mobile = TextEditingController(text: '+63');

  String displayedName = 'Mingsy'; // Default name shown at top

   @override
  void initState() {
    super.initState();
    displayedName = widget.displayName;
  }

  void saveProfile() {
  final updatedName = nickname.text.trim().isNotEmpty
      ? nickname.text.trim()
      : firstName.text.trim();

  // Show the snackbar BEFORE popping, or remove this if not needed
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Profile saved successfully!')),
  );

  // Pop and send data back to main screen
  Navigator.pop(context, {
    'name': updatedName,
    'imagePath': widget.imagePath,
  });

  Navigator.pop(context, {
  'name': updatedName,
  'imagePath': widget.imagePath,
  'email': email.text.trim(),
  'mobile': mobile.text.trim(),
});

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'User Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
                    radius: 50,
                    backgroundImage: widget.imagePath != null
                        ? FileImage(File(widget.imagePath!)) as ImageProvider
                        : const AssetImage('assets/images/default_avatar.png'),
                  ),


            const SizedBox(height: 12),
            Text(
              displayedName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 24),
            buildTextField('First Name', firstName),
            const SizedBox(height: 16),
            buildTextField('Last Name', lastName),
            const SizedBox(height: 16),
            buildTextField('Nickname', nickname),
            const SizedBox(height: 16),
            buildTextField('E-Mail', email, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            buildTextField('Mobile', mobile, keyboardType: TextInputType.phone),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: saveProfile,
              child: const Text(
                'SAVE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.teal),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.teal, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
