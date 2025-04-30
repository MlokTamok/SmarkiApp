import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarkiapp2/account.dart';
import 'package:smarkiapp2/devicemenu.dart';
import 'package:smarkiapp2/language.dart';
import 'package:smarkiapp2/scanner.dart';

class DevicesScreen extends StatefulWidget {
  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;

    if (currentUser == null) {
      return Scaffold(
        body: Center(child: Text("Please log in to view your devices")),
      );
    }

    final userEmail = currentUser.email?.trim().toLowerCase();
    print("🧪 Logged in as: $userEmail");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAAD2BA),
        title: const Text(
          "Your Devices",
          style: TextStyle(
              color: Color.fromRGBO(63, 80, 66, 1), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: const Color.fromRGBO(107, 143, 113, 1),
            icon: const Icon(Icons.menu_rounded, color: Color.fromRGBO(63, 80, 66, 1)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.grey),
            ),
            itemBuilder: (context) => [
              _buildMenuItem("Language", Icons.language, () => Language()),
              _buildMenuItem("Country", Icons.public, () => Language()),
              _buildMenuItem("Time Zone", Icons.access_time, () => Language()),
              _buildMenuItem("Account", Icons.account_box, () => Account()),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Device')
              .where('user_email', isEqualTo: userEmail)
              .orderBy('created_at', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("❌ Firestore error: ${snapshot.error}");
              return const Center(child: Text("Error loading devices"));
            }

            if (!snapshot.hasData) {
              print("⏳ Waiting for data...");
              return const Center(child: CircularProgressIndicator());
            }

            final docs = snapshot.data!.docs;
            print("📦 Firestore returned ${docs.length} devices");

            if (docs.isEmpty) {
              return const Center(child: Text("No devices found for this user"));
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final device = docs[index];
                final data = device.data() as Map<String, dynamic>;

                final name = data['Name'] ?? 'Unnamed';
                final location = data['Location'] ?? 'No location';

                return ListTile(
                  title: Text(name),
                  subtitle: Text("Location: $location"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DeviceMenu(
                          device: {
                            'id': device.id,
                            'name': name,
                            'Location': data['Location'],
                            'Town': data['Town'],
                            'Street': data['Street'],
                            'House Number': data['House Number'],
                            'Floor': data['Floor'],
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddDeviceFlowScreen()),
          );
          setState(() {}); // Refresh after adding a device
        },
        backgroundColor: const Color.fromARGB(255, 150, 185, 164),
        child: const Icon(Icons.add, color: Color.fromRGBO(185, 245, 216, 1)),
      ),
    );
  }

  PopupMenuItem _buildMenuItem(String title, IconData icon, Widget Function() page) {
    return PopupMenuItem(
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Colors.white)),
        ],
      ),
      onTap: () => Future.delayed(Duration.zero, () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page()));
      }),
    );
  }
}
