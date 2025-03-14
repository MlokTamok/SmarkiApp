import 'package:flutter/material.dart';

class AddDeviceScreen extends StatefulWidget {
  final Function(Map<String, String>) onDeviceAdded;

  AddDeviceScreen({required this.onDeviceAdded});

  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _deviceNameController = TextEditingController();
  final _deviceLocationController = TextEditingController();

  void saveDevice() {
    if (_deviceNameController.text.isNotEmpty && _deviceLocationController.text.isNotEmpty) {
      Map<String, String> newDevice = {
        'name': _deviceNameController.text,
        'location': _deviceLocationController.text,
      };

      widget.onDeviceAdded(newDevice);

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill in all device details")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Device'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _deviceNameController,
              decoration: InputDecoration(labelText: "Device Name"),
            ),
            TextField(
              controller: _deviceLocationController,
              decoration: InputDecoration(labelText: "Device Location"),
            ),
            ElevatedButton(
              onPressed: saveDevice,
              child: Text("Save Device"),
            ),
          ],
        ),
      ),
    );
  }
}
