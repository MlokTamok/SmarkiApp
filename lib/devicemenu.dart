import 'package:flutter/material.dart';
import 'package:smarkiapp2/editdevice.dart';



class DeviceMenu extends StatelessWidget {
  final Map<String, String> device; // Accept device data

  DeviceMenu({required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device['name'] ?? 'Device Menu'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDeviceScreen(device: device), // Navigate to edit screen
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Device Location: ${device['location']}"),
      ),
    );
  }
}
