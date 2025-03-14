import 'dart:convert'; // Pro práci s JSON
import 'package:shared_preferences/shared_preferences.dart';

void saveDevice(Map<String, dynamic> device) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Serializujeme seznam uživatelů do JSON
  if (device['users'] != null) {
    String usersJson = json.encode(device['users']);
    device['users'] = usersJson;  // Uložíme seznam uživatelů jako JSON string
  }

  // Serializujeme celé zařízení do JSON
  String deviceJson = json.encode(device);

  // Uložíme zařízení do SharedPreferences
  await prefs.setString('device_key', deviceJson);
}

Future<Map<String, dynamic>> loadDevice() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? deviceJson = prefs.getString('device_key');  // Načteme zařízení

  if (deviceJson != null) {
    Map<String, dynamic> device = json.decode(deviceJson);  // Deserializujeme zařízení

    // Deserializujeme seznam uživatelů, pokud existuje
    if (device['users'] != null) {
      List<Map<String, String>> users = List<Map<String, String>>.from(json.decode(device['users']));
      device['users'] = users;
    }

    return device;
  }

  return {};  // Pokud zařízení neexistuje, vrátíme prázdný objekt
}
