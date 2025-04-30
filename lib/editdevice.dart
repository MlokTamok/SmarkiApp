import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDeviceScreen extends StatefulWidget {
  final String deviceId;
  final Map<String, dynamic> deviceData;

  const EditDeviceScreen({Key? key, required this.deviceId, required this.deviceData}) : super(key: key);

  @override
  _EditDeviceScreenState createState() => _EditDeviceScreenState();
}

class _EditDeviceScreenState extends State<EditDeviceScreen> {
  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController townController;
  late TextEditingController streetController;
  late TextEditingController houseNumberController;
  late TextEditingController floorController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.deviceData['Name']);
    locationController = TextEditingController(text: widget.deviceData['Location']);
    townController = TextEditingController(text: widget.deviceData['Town']);
    streetController = TextEditingController(text: widget.deviceData['Street']);
    houseNumberController = TextEditingController(text: widget.deviceData['House Number']);
    floorController = TextEditingController(text: widget.deviceData['Floor']);
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    townController.dispose();
    streetController.dispose();
    houseNumberController.dispose();
    floorController.dispose();
    super.dispose();
  }

  Future<void> saveChanges() async {
    await FirebaseFirestore.instance
        .collection('Device')
        .doc(widget.deviceId)
        .update({
      'Name': nameController.text,
      'Location': locationController.text,
      'Town': townController.text,
      'Street': streetController.text,
      'House Number': houseNumberController.text,
      'Floor': floorController.text,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Device updated successfully!')),
    );
    Navigator.pop(context); // Go back to device list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAAD2BA),
        title: Text(
          nameController.text.isEmpty ? "Device Details" : nameController.text,
          style: const TextStyle(color: Color.fromRGBO(63, 80, 66, 1), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildTextField("Device Name", nameController),
            buildTextField("Location", locationController),
            buildTextField("Town", townController),
            buildTextField("Street", streetController),
            buildTextField("House Number", houseNumberController),
            buildTextField("Floor", floorController),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAAD2BA),
              ),
              onPressed: saveChanges,
              child: const Text(
                'Save Changes',
                style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
