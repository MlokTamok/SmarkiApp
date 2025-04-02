import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarkiapp2/add_device_screen.dart';
import 'package:smarkiapp2/devicemenu.dart';
import 'package:smarkiapp2/account.dart';
import 'package:smarkiapp2/language.dart';

class DevicesScreen extends StatefulWidget {
  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
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
          title:
          Text("Your Devices", 
          style: 
          TextStyle(
            color: const Color.fromRGBO(63, 80, 66, 1),
          fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: Color.fromRGBO(107, 143, 113, 1),
            icon: Icon(Icons.menu_rounded),
            iconColor: Color.fromRGBO(63, 80, 66, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey)
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: 
                Row(
                  children: [
                    Icon(Icons.language, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text("Language", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Language()),
                  );
                },
                ),
               PopupMenuItem(
                child: 
                Row(
                  children: [
                    Icon(Icons.public, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text("Country", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Language()),
                  );
                },
                ),
              PopupMenuItem(
                child: 
                Row(
                  children: [
                    Icon(Icons.access_time, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text("Time Zone", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Language()),
                  );
                },
                ),
              PopupMenuItem(
                child: 
                Row(
                  children: [
                    Icon(Icons.account_box, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text("Account", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Account()),
                  );
                },
                ),
        ],
     ),]
     ),
      body: devices.isEmpty
          ? const Center(child: Text("No devices added yet"))
          : ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                return ListTile(
                  title: Text(device['name'] ?? 'No Name'),
                  subtitle: Text('Location: ${device['location'] ?? 'Unknown'}'),
                  onTap: () async {
                  final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => DeviceMenu(device: device),
                  ),
                  );

                  if (result == 'deleted') {
                setState(() {
                devices.removeWhere((d) => d['name'] == device['name']);
                saveDevices();
                });
                }
                },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ignore: unused_local_variable
          final newDevice = await Navigator.push(
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
        backgroundColor: const Color.fromARGB(255, 150, 185, 164),
        child: const Icon(Icons.add, color: Color.fromRGBO(185, 245, 216, 1)),
      ),
    );
  }

}
