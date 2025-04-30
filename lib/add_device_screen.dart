import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarkiapp2/deices.dart';

class AddDeviceScreen extends StatefulWidget {
  final String scannedCode;

  AddDeviceScreen({Key? key, required this.scannedCode}) : super(key: key);

  @override
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  Future<void> _saveDevice() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final name = _nameController.text.trim();
    final location = _locationController.text.trim();

    if (name.isNotEmpty && location.isNotEmpty && currentUser != null) {
      try {
        await FirebaseFirestore.instance.collection('Device').add({
          'user_id': currentUser.uid,
          'user_email': currentUser.email,
          'code': widget.scannedCode,  // The scanned code
          'Name': name,
          'Location': location,
          'created_at': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device added successfully!')),
        );

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => DevicesScreen()),
          );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add device: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Device")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Device Name'),
            ),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Device Location'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveDevice,
              child: const Text('Save Device'),
            ),
          ],
        ),
      ),
    );
  }
}
