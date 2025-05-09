import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarkiapp2/deices.dart';

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

  late TextEditingController otherNameController;
  late TextEditingController otherSurnameController;
  late TextEditingController otherPhoneController;
  String selectedConnection = 'Nothing';

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.deviceData['Name']);
    locationController = TextEditingController(text: widget.deviceData['Location']);
    townController = TextEditingController(text: widget.deviceData['Town']);
    streetController = TextEditingController(text: widget.deviceData['Street']);
    houseNumberController = TextEditingController(text: widget.deviceData['House Number']);
    floorController = TextEditingController(text: widget.deviceData['Floor']);

    otherNameController = TextEditingController();
    otherSurnameController = TextEditingController();
    otherPhoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    townController.dispose();
    streetController.dispose();
    houseNumberController.dispose();
    floorController.dispose();

    otherNameController.dispose();
    otherSurnameController.dispose();
    otherPhoneController.dispose();
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
    Navigator.pop(context);
  }

Future<void> deleteDevice() async {
  bool shouldDelete = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(
        'Delete Device',
        style: TextStyle(
          color: Color.fromRGBO(63, 80, 66, 1),
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Are you sure you want to delete this device? This action cannot be undone.',
        style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1)),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1)),
          ),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.red),
          ),
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

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DevicesScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting device: $e')),
      );
    }
  }
}


  Future<void> addOtherUser() async {
    if (otherNameController.text.isEmpty || otherSurnameController.text.isEmpty || otherPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all user fields')),
      );
      return;
    }

    await FirebaseFirestore.instance.collection('Users').add({
      'deviceId': widget.deviceId,
      'name': otherNameController.text.trim(),
      'surname': otherSurnameController.text.trim(),
      'connection': selectedConnection,
      'phoneNumber': otherPhoneController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Other user added')),
    );

    otherNameController.clear();
    otherSurnameController.clear();
    otherPhoneController.clear();
    setState(() {
      selectedConnection = 'Nothing';
    });
  }

  Future<void> deleteUser(String userId) async {
    await FirebaseFirestore.instance.collection('Users').doc(userId).delete();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User deleted')));
  }

  Future<void> editUser(Map<String, dynamic> userData, String userId) async {
    TextEditingController nameCtrl = TextEditingController(text: userData['name']);
    TextEditingController surnameCtrl = TextEditingController(text: userData['surname']);
    TextEditingController phoneCtrl = TextEditingController(text: userData['phoneNumber']);
    String selectedConn = userData['connection'];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit User', 
          style: TextStyle(
            color: Color.fromRGBO(63, 80, 66, 1),
            fontWeight: FontWeight.bold
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),

                TextField(
                  controller: surnameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Surname',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),

                TextField(
                  controller: phoneCtrl,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                    filled: true,
                  ),
                  keyboardType: TextInputType.phone
                ),
                SizedBox(height: 10),

                DropdownButtonFormField<String>(
                  value: selectedConn,
                  decoration: InputDecoration(
                    labelText: 'Connection',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                    filled: true,
                  ),
                  items: ['Nothing', 'Friend', 'Neighbor', 'Family member'].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedConn = value!;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('Users').doc(userId).update({
                  'name': nameCtrl.text.trim(),
                  'surname': surnameCtrl.text.trim(),
                  'phoneNumber': phoneCtrl.text.trim(),
                  'connection': selectedConn,
                });

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User updated')));
                Navigator.of(context).pop();
              },
              child: const Text('Save Changes',
              style: TextStyle(
                color: Color.fromRGBO(63, 80, 66, 1)
              ),),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel',
              style: TextStyle(
                color: Colors.red
              ),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAAD2BA),
        title: Text(
          nameController.text.isEmpty ? "Device Details" : nameController.text,
          style: const TextStyle(
            color: Color.fromRGBO(63, 80, 66, 1), 
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: Color.fromRGBO(63, 80, 66, 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Device Stettings',
              style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1), fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Device Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
          ),
          SizedBox(height: 10),

          TextField(
            controller: locationController,
            decoration: InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
          ),
          SizedBox(height: 10),

          TextField(
            controller: townController,
            decoration: InputDecoration(
              labelText: 'Town',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
          ),
          SizedBox(height: 10),

          TextField(
            controller: streetController,
            decoration: InputDecoration(
              labelText: 'Street',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
          ),
          SizedBox(height: 10),

          TextField(
            controller: houseNumberController,
            decoration: InputDecoration(
              labelText: 'House Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
          ),
          SizedBox(height: 10),

          TextField(
            controller: floorController,
            decoration: InputDecoration(
              labelText: 'Floor',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
          ),
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
            const SizedBox(height: 30),
            const Text(
              'Add Other User',
              style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1), fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
            controller: otherNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
          ),
            const SizedBox(height: 10),
            TextField(
            controller: otherSurnameController,
            decoration: InputDecoration(
              labelText: 'Surname',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
          ),
            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              value: selectedConnection,
              decoration: InputDecoration(
                labelText: 'Connection',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
                fillColor: const Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              items: ['Nothing', 'Friend', 'Neighbor', 'Family member'].map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedConnection = value!;
                });
              },
            ),
            SizedBox(height: 10,),
            TextField(
            controller: otherPhoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
            ),
            keyboardType: TextInputType.phone
          ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFAAD2BA),
              ),
              onPressed: addOtherUser,
              child: const Text(
                'Add Member',
                style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1), fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Other Users',
              style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1), fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .where('deviceId', isEqualTo: widget.deviceId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Text("No associated users.",
                  style: TextStyle(
                    color: Color.fromRGBO(63, 80, 66, 1)
                  ),);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text('${data['name']} ${data['surname']}'),
                      subtitle: Text('${data['connection']} • ${data['phoneNumber']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: const Icon(Icons.edit), onPressed: () => editUser(data, doc.id)),
                          IconButton(icon: const Icon(Icons.delete), onPressed: () => deleteUser(doc.id)),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
