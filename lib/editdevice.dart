import 'package:flutter/material.dart';
import 'package:smarkiapp2/device_storage.dart';

class EditDeviceScreen extends StatefulWidget {
  final Map<String, dynamic> device;

  EditDeviceScreen({required this.device});

  @override
  _EditDeviceScreenState createState() => _EditDeviceScreenState();
}

class _EditDeviceScreenState extends State<EditDeviceScreen> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;

  final _userNameController = TextEditingController();
  final _userLastNameController = TextEditingController();
  final _userPhoneController = TextEditingController();

  List<Map<String, String>> users = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.device['name']);
    _locationController = TextEditingController(text: widget.device['location']);

    if (widget.device['users'] != null) {
      users = List<Map<String, String>>.from(widget.device['users']);
    }
  }

  void addUser() {
    if (_userNameController.text.isNotEmpty &&
        _userLastNameController.text.isNotEmpty &&
        _userPhoneController.text.isNotEmpty) {
      setState(() {
        users.add({
          'name': _userNameController.text,
          'lastName': _userLastNameController.text,
          'phone': _userPhoneController.text,
        });
        _userNameController.clear();
        _userLastNameController.clear();
        _userPhoneController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all user fields.")),
      );
    }
  }

  void saveChanges() async {
    widget.device['name'] = _nameController.text;
    widget.device['location'] = _locationController.text;
    //widget.device['users'] = users;

    saveDevice(widget.device);
    Navigator.pop(context, widget.device);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAAD2BA),
        title: Text("Edit Device",style: TextStyle(
              color: const Color.fromRGBO(63, 80, 66, 1),
              fontWeight: FontWeight.bold,
            ),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
      Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Device Name"),
              ),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(labelText: "Device Location"),
              ),
              SizedBox(height: 25),
              Text("Add Users", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: "User First Name"),
              ),
              TextField(
                controller: _userLastNameController,
                decoration: InputDecoration(labelText: "User Last Name"),
              ),
              TextField(
                controller: _userPhoneController,
                decoration: InputDecoration(labelText: "User Phone Number"),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: addUser,
                child: Text("Add User"),
              ),
              SizedBox(height: 20),
              Text("Users List:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${users[index]['name']} ${users[index]['lastName']}'),
                    subtitle: Text('Phone: ${users[index]['phone']}'),
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveChanges,
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}