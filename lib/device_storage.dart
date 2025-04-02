import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveDevice(Map<String, dynamic> device) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Convert users list to JSON if it exists
  if (device['users'] != null) {
    device['users'] = json.encode(device['users']);
  }

  String deviceJson = json.encode(device);
  await prefs.setString('device_key', deviceJson);
}

Future<Map<String, dynamic>> loadDevice() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? deviceJson = prefs.getString('device_key');

  if (deviceJson != null) {
    Map<String, dynamic> device = json.decode(deviceJson);

    // Convert users from JSON back to list
    if (device['users'] != null) {
      device['users'] = List<Map<String, String>>.from(json.decode(device['users']));
    }

    return device;
  }

  return {}; // Return an empty object if no device is found
}

Future<void> deleteDeviceFromStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('device_key'); // Completely remove device data
}

