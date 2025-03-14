import 'dart:convert';  // Import pro JSON
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

  // Načítání zařízení z SharedPreferences
  Future<void> loadDevices() async {
    final prefs = await SharedPreferences.getInstance();
    final String? devicesData = prefs.getString('devices');
    if (devicesData != null) {
      // Pokusíme se dekódovat JSON, pokud je dostupný
      List<dynamic> jsonList = json.decode(devicesData); // Deserializace JSON řetězce na seznam
      setState(() {
        devices = jsonList.map((item) => Map<String, String>.from(item)).toList(); // Převedeme na seznam map
      });
    }
  }

  // Ukládání zařízení do SharedPreferences
  Future<void> saveDevices() async {
    final prefs = await SharedPreferences.getInstance();
    String devicesJson = json.encode(devices);  // Serializujeme do JSON
    prefs.setString('devices', devicesJson); // Uložíme jako JSON řetězec
  }

  @override
  void initState() {
    super.initState();
    loadDevices();  // Načteme zařízení při startu obrazovky
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
                    saveDevices(); // Uložíme nové zařízení
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
