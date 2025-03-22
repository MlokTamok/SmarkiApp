import 'package:flutter/material.dart';
import 'package:smarkiapp2/editdevice.dart';

class DeviceMenu extends StatelessWidget {
  final Map<String, String> device;

  DeviceMenu({required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAAD2BA),
        title: Text(device['name'] ?? 'Device Menu', style: TextStyle(
              color: const Color.fromRGBO(63, 80, 66, 1),
              fontWeight: FontWeight.bold,
            ),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDeviceScreen(device: device),
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
