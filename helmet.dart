import 'package:flutter/material.dart';

class HelmetTab extends StatefulWidget {
  const HelmetTab({super.key});

  @override
  State<HelmetTab> createState() => _HelmetTabState();
}

class _HelmetTabState extends State<HelmetTab> {
  String helmetBrand = "Shox Sniper Solid";
  String helmetColor = "Black";
  String motorcycleName = "Royal Enfield 650 Interceptor";
  String motorcycleColor = "Black";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Helmet Images
          SizedBox(
            height: 130,
            child: Center(
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 8),
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () => _showZoomImage(context, 'assets/images/helmet1.jpg'),
                    child: helmetImage('assets/images/helmet1.jpg'),
                  ),
                  GestureDetector(
                    onTap: () => _showZoomImage(context, 'assets/images/helmet2.jpg'),
                    child: helmetImage('assets/images/helmet2.jpg'),
                  ),
                  GestureDetector(
                    onTap: () => _showZoomImage(context, 'assets/images/helmet3.jpg'),
                    child: helmetImage('assets/images/helmet3.jpg'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Helmet Card
          infoCard(
            title: "About my helmet",
            subtitle1: helmetBrand,
            subtitle2: helmetColor,
            icon: const ImageIcon(
              AssetImage('assets/icons/helmet2.png'),
              size: 32,
              color: Colors.teal,
            ),
            onEdit: () => _showHelmetEditDialog(context),
          ),

          // Motorcycle Card
          infoCard(
            title: "About my motorcycle",
            subtitle1: motorcycleName,
            subtitle2: motorcycleColor,
            icon: const ImageIcon(
              AssetImage('assets/icons/motor2.png'),
              size: 32,
              color: Colors.teal,
            ),
            onEdit: () => _showMotorcycleEditDialog(context),
          ),
        ],
      ),
    );
  }

  // Helmet Edit Dialog
  void _showHelmetEditDialog(BuildContext context) {
    final brandController = TextEditingController(text: helmetBrand);
    final colorController = TextEditingController(text: helmetColor);

    showDialog(
      context: context,
      builder: (context) {
        return _buildEditDialog(
          context: context,
          title: "Edit My Helmet",
          icon1: Icons.sports_motorsports,
          label1: "Brand",
          controller1: brandController,
          icon2: Icons.opacity,
          label2: "Color",
          controller2: colorController,
          onSave: () {
            setState(() {
              helmetBrand = brandController.text;
              helmetColor = colorController.text;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Motorcycle Edit Dialog
  void _showMotorcycleEditDialog(BuildContext context) {
    final nameController = TextEditingController(text: motorcycleName);
    final colorController = TextEditingController(text: motorcycleColor);

    showDialog(
      context: context,
      builder: (context) {
        return _buildEditDialog(
          context: context,
          title: "Edit My Motorcycle",
          icon1: Icons.two_wheeler,
          label1: "Motorcycle Name",
          controller1: nameController,
          icon2: Icons.color_lens,
          label2: "Color",
          controller2: colorController,
          onSave: () {
            setState(() {
              motorcycleName = nameController.text;
              motorcycleColor = colorController.text;
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Reusable Edit Dialog Widget
  Widget _buildEditDialog({
    required BuildContext context,
    required String title,
    required IconData icon1,
    required String label1,
    required TextEditingController controller1,
    required IconData icon2,
    required String label2,
    required TextEditingController controller2,
    required VoidCallback onSave,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

           // Field 1
Row(
  children: [
    Icon(icon1, color: Colors.teal),
    const SizedBox(width: 10),
    Expanded(
      child: TextField(
        controller: controller1,
        decoration: InputDecoration(
          labelText: label1,
          labelStyle: const TextStyle(color: Colors.teal),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
      ),
    ),
  ],
),
const SizedBox(height: 15),

// Field 2
Row(
  children: [
    Icon(icon2, color: Colors.teal),
    const SizedBox(width: 10),
    Expanded(
      child: TextField(
        controller: controller2,
        decoration: InputDecoration(
          labelText: label2,
          labelStyle: const TextStyle(color: Colors.teal),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
      ),
    ),
  ],
),


            const SizedBox(height: 20),
            const Divider(thickness: 1.2),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.white),),
                ),


                ElevatedButton(
                  onPressed: onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'CONFIRM',
                    style: TextStyle(color: Colors.white),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Helmet Image Widget
  Widget helmetImage(String path) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Info Card Widget
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
            offset: const Offset(0, 2),
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
                    const Icon(Icons.verified_user, size: 16, color: Colors.teal),
                    const SizedBox(width: 6),
                    Text(subtitle1),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.palette, size: 16, color: Colors.teal),
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

  // Zoom image dialog
  void _showZoomImage(BuildContext context, String path) {
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
}
