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
      const SnackBar(content: Text('Device updated successfully!')),
    );
    Navigator.pop(context); // Go back to device list
  }

  Future<void> deleteDevice() async {
    bool shouldDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Device'),
        content: const Text('Are you sure you want to delete this device? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    ) ?? false;

    if (shouldDelete) {
      try {
        await FirebaseFirestore.instance
            .collection('Device')
            .doc(widget.deviceId)
            .delete();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device deleted successfully!')),
        );
        Navigator.pop(context); // Go back to device list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting device: $e')),
        );
      }
    }
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
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 247, 65, 65),
              ),
              onPressed: deleteDevice,
              child: const Text(
                'Delete Device',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
