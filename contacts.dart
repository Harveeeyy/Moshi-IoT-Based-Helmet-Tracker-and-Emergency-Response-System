import 'package:flutter/material.dart';

class ContactsTab extends StatefulWidget {
  const ContactsTab({super.key});

  @override
  State<ContactsTab> createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  // Hospital contact details
  Map<String, String> hospital = {
    'name': 'Batangas Medical Center (BatMC)',
    'phone': '(043) 740-8307',
    'image': 'assets/images/default_avatar.png'
  };

  // Limit the emergency contacts list to 4
  List<Map<String, String>> contacts = [
    {'name': 'Mom', 'phone': '0917-834-6259', 'image': 'assets/images/default_avatar.png'},
    {'name': 'Dad', 'phone': '0998-412-3075', 'image': 'assets/images/default_avatar.png'},
    {'name': 'My Fiance', 'phone': '0921-573-8842', 'image': 'assets/images/default_avatar.png'},
    {'name': 'Sister', 'phone': '0918-123-4567', 'image': 'assets/images/default_avatar.png'},
  ];

  // Show dialog for adding/editing a contact
  void _showContactDialog({int? index}) {
    final isEditing = index != null;
    final TextEditingController nameController = TextEditingController(
      text: isEditing ? contacts[index]['name'] : '',
    );
    final TextEditingController phoneController = TextEditingController(
      text: isEditing ? contacts[index]['phone'] : '',
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(isEditing ? 'Edit Contact' : 'Add Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              if (name.isNotEmpty && phone.isNotEmpty) {
                setState(() {
                  if (isEditing) {
                    contacts[index] = {
                      'name': name,
                      'phone': phone,
                      'image': contacts[index]['image'] ?? 'assets/images/default_avatar.png',
                    };
                  } else {
                    if (contacts.length < 4) {
                      contacts.add({
                        'name': name,
                        'phone': phone,
                        'image': 'assets/images/default_avatar.png',
                      });
                    } else {
                      // Show a SnackBar if more than 4 contacts are added
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You can only add up to 4 contacts!'),
                          backgroundColor: Color.fromARGB(255, 155, 17, 7),
                        ),
                      );
                    }
                  }
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // Show dialog to edit hospital contact info
  void _showHospitalDialog() {
    final TextEditingController nameController = TextEditingController(text: hospital['name']);
    final TextEditingController phoneController = TextEditingController(text: hospital['phone']);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Hospital Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Hospital Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              if (name.isNotEmpty && phone.isNotEmpty) {
                setState(() {
                  hospital['name'] = name;
                  hospital['phone'] = phone;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(  // Wrap the entire content in a SingleChildScrollView to make it scrollable
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Hospital Information Section
            const SectionHeader(icon: Icons.local_hospital, title: 'Hospital'),
            ContactCard(
              imagePath: hospital['image']!,
              name: hospital['name']!,
              phone: hospital['phone']!,
              onEdit: _showHospitalDialog,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _showHospitalDialog,
              icon: const Icon(Icons.edit),
              label: const Text('Change Hospital Contact'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Emergency Contacts Section
            const SectionHeader(icon: Icons.phone, title: 'Emergency Contacts'),
            ...contacts.asMap().entries.map((entry) {
              final index = entry.key;
              final contact = entry.value;
              return ContactCard(
                imagePath: contact['image']!,
                name: contact['name']!,
                phone: contact['phone']!,
                onEdit: () => _showContactDialog(index: index),
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _showContactDialog(),
              icon: const Icon(Icons.add),
              label: const Text('Add Emergency Contact'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SectionHeader Widget
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

// ContactCard Widget
class ContactCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String phone;
  final VoidCallback? onEdit;

  const ContactCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.phone,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (onEdit != null)
            InkWell(
              onTap: onEdit,
              child: Row(
                children: const [
                  Text('Edit', style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
