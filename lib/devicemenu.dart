import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarkiapp2/Osvetleni%20a%20odsavani.dart';
import 'package:smarkiapp2/Security.dart';
import 'package:smarkiapp2/Video%20prezentace.dart';
import 'package:smarkiapp2/editdevice.dart';
import 'package:smarkiapp2/sterilizace.dart';

class DeviceMenu extends StatefulWidget {
  final Map<String, dynamic> device;

  DeviceMenu({required this.device});

  @override
  State<DeviceMenu> createState() => _DeviceMenuState();
}

class _DeviceMenuState extends State<DeviceMenu> {
  @override
  Widget build(BuildContext context) {
    final deviceId = widget.device['id'];

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('Device').doc(deviceId).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading device data')),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final name = data['Name'] ?? 'Device Menu';
        final deviceData = {
          'Name': name,
          'Location': data['Location'],
          'Town': data['Town'],
          'Street': data['Street'],
          'House Number': data['House Number'],
          'Floor': data['Floor'],
        };

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFAAD2BA),
            title: Text(
              name,
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
              crossAxisCount: 2,
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
                        builder: (context) => OsvetleniOdsavani(
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
                  icon1: Icons.audio_file,
                  icon2: Icons.video_file,
                  text: 'Audio\n& Video',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioAndVideo(
                          deviceId: deviceId,
                          deviceData: deviceData,
                        ),
                      ),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Security(
                          deviceId: deviceId,
                          deviceData: deviceData,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
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
