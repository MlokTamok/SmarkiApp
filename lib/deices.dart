import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarkiapp2/add_device_screen.dart';
import 'package:smarkiapp2/devicemenu.dart';

class Devices_Screen extends StatefulWidget {
  @override
  _Devices_ScreenState createState() => _Devices_ScreenState();
}

class _Devices_ScreenState extends State<Devices_Screen> {
  List<Map<String, String>> devices = [];

  Future<void> loadDevices() async {
    final prefs = await SharedPreferences.getInstance();
    final String? devicesData = prefs.getString('devices');
    if (devicesData != null) {
      List<dynamic> jsonList = json.decode(devicesData);
      setState(() {
        devices = jsonList.map((item) => Map<String, String>.from(item)).toList();
      });
    }
  }

  Future<void> saveDevices() async {
    final prefs = await SharedPreferences.getInstance();
    String devicesJson = json.encode(devices); 
    prefs.setString('devices', devicesJson);
  }

  @override
  void initState() {
    super.initState();
    loadDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAAD2BA),
        title: Text(
          "Your Devices",
          style: TextStyle(
            color: const Color.fromRGBO(63, 80, 66, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: devices.isEmpty
          ? Center(child: Text("No devices added yet"))
          : ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(devices[index]['name'] ?? 'No Name'),
                  subtitle: Text('Location: ${devices[index]['location']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeviceMenu(device: devices[index]),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDeviceScreen(
                onDeviceAdded: (newDevice) {
                  setState(() {
                    devices.add(newDevice);
                    saveDevices();
                  });
                },
              ),
            ),
          );
        },
        backgroundColor: Color.fromARGB(255, 150, 185, 164),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
