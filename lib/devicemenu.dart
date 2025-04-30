import 'package:flutter/material.dart';
import 'package:smarkiapp2/editdevice.dart';
import 'package:smarkiapp2/sterilizace.dart';

class DeviceMenu extends StatelessWidget {
  final Map<String, dynamic> device;

  DeviceMenu({required this.device});

  @override
  Widget build(BuildContext context) {
    final deviceId = device['id'];
    final deviceData = {
      'Name': device['name'],
      'Location': device['Location'],
      'Town': device['Town'],
      'Street': device['Street'],
      'House Number': device['House Number'],
      'Floor': device['Floor'],
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAAD2BA),
        title: Text(
          device['name'] ?? 'Device Menu',
          style: TextStyle(
            color: const Color.fromRGBO(63, 80, 66, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromRGBO(63, 80, 66, 1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,  // Adjust the number of columns here
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          children: [
            buildMenuButton(
              icon1: Icons.lightbulb,
              icon2: Icons.air,
              text: 'Lighting\n& Extraction',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sterilizace(
                      deviceId: deviceId,
                      deviceData: deviceData,
                    ),
                  ),
                );
              },
            ),
            buildMenuButton(
              icon: Icons.light,
              text: 'Sterilization',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sterilizace(
                      deviceId: deviceId,
                      deviceData: deviceData,
                    ),
                  ),
                );
              },
            ),
            buildMenuButton(
              icon: Icons.soup_kitchen,
              text: 'Cooking',
              onPressed: () {
                print('Cooking tapped: $deviceId');
              },
            ),
            buildMenuButton(
              icon: Icons.video_file,
              text: 'Audio\n& Video',
              onPressed: () {
                print('Audio & Video tapped: $deviceId');
              },
            ),
            buildMenuButton(
              icon: Icons.home,
              text: 'Household\nmanagement',
              onPressed: () {
                print('Household tapped: $deviceId');
              },
            ),
            buildMenuButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDeviceScreen(
                      deviceId: deviceId,
                      deviceData: deviceData,
                    ),
                  ),
                );
              },
            ),
            buildMenuButton(
              icon: Icons.lock,
              text: 'Security',
              onPressed: () {
                print('Security tapped: $deviceId');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton({
    IconData? icon,
    IconData? icon1,
    IconData? icon2,
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Color.fromRGBO(107, 143, 113, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(icon, size: 55, color: Color.fromRGBO(185, 245, 216, 1)),
          if (icon1 != null && icon2 != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon1, size: 40, color: Color.fromRGBO(185, 245, 216, 1)),
                Icon(icon2, size: 37, color: Color.fromRGBO(185, 245, 216, 1)),
              ],
            ),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromRGBO(185, 245, 216, 1)),
          ),
        ],
      ),
    );
  }
}
