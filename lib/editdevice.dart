import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late TextEditingController _townController;
  late TextEditingController _streetController;
  late TextEditingController _housenumberController;
  late TextEditingController _floorController;

  final _userNameController = TextEditingController();
  final _userLastNameController = TextEditingController();
  final _userPhoneController = TextEditingController();

  List<Map<String, String>> users = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.device['name']);
    _locationController = TextEditingController(text: widget.device['location']);
    _townController = TextEditingController(text: widget.device['town']);
    _streetController = TextEditingController(text: widget.device['street']);
    _housenumberController = TextEditingController(text: widget.device['housenumber']);
    _floorController = TextEditingController(text: widget.device['floor']);

    if (widget.device['users'] != null) {
      users = List<Map<String, String>>.from(widget.device['users']);
    }
  }
  

  void addUser() {
  if (_userNameController.text.isNotEmpty &&
      _userLastNameController.text.isNotEmpty &&
      _userPhoneController.text.isNotEmpty) {
    final newUser = {
      'name': _userNameController.text,
      'lastName': _userLastNameController.text,
      'phone': _userPhoneController.text,
    };

    if (users.any((user) =>
        user['name'] == newUser['name'] &&
        user['lastName'] == newUser['lastName'] &&
        user['phone'] == newUser['phone'])) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("This user already exists.")),
      );
    } else {
      setState(() {
        users.add(newUser);
        _userNameController.clear();
        _userLastNameController.clear();
        _userPhoneController.clear();
      });
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill in all user fields.")),
    );
  }
}


  void saveChanges() async {
    widget.device['name'] = _nameController.text;
    widget.device['location'] = _locationController.text;
    widget.device['town'] = _townController.text;
    widget.device['street'] = _streetController.text;
    widget.device['housenumber'] = _housenumberController.text;
    widget.device['floor'] = _floorController.text;
    //widget.device['users'] = users;

    saveDevice(widget.device);
    Navigator.pop(context, widget.device);
  }

  void deleteDevice() async {
  final prefs = await SharedPreferences.getInstance();
  List<dynamic> devicesList = json.decode(prefs.getString('devices') ?? '[]');
  devicesList.removeWhere((d) => d['name'] == widget.device['name']);
  await prefs.setString('devices', json.encode(devicesList));
  Navigator.pop(context, 'deleted');
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
          icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromRGBO(63, 80, 66, 1),),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
      Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 6,),
              TextField(
                controller: _nameController,
                decoration: 
                InputDecoration(
                  labelText: "Device Name",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
              ),
              SizedBox(height: 12,),

              TextField(
                controller: _locationController,
                decoration: 
                InputDecoration(
                  labelText: "Device Location",                  
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
              ),
              SizedBox(height: 12,),

              TextFormField(
                controller: _townController,
                decoration: InputDecoration(
                  labelText: "Town",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
              ),
              SizedBox(height: 20),

              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(
                  labelText: "Street",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
              ),
              SizedBox(height: 12,),

              TextFormField(
                controller: _housenumberController,
                decoration: InputDecoration(
                  labelText: "House Number",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
              ),
              SizedBox(height: 12,),

              TextFormField(
                controller: _floorController,
                decoration: InputDecoration(
                  labelText: "Floor",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
              ),
              SizedBox(height: 12,),


              Text("Other Users", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 12,),

              TextField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: "User First Name",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
              ),
              SizedBox(height: 12,),

              TextField(
                controller: _userLastNameController,
                decoration: InputDecoration(labelText: "User Last Name",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
              ),
              SizedBox(height: 12,),

              TextField(
                controller: _userPhoneController,
                decoration: InputDecoration(labelText: "User Phone Number",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 12,),
              ElevatedButton(
                onPressed: addUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child: Text("Add User", style: TextStyle(color: Color.fromRGBO(185, 245, 216, 1),),),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child: Text("Save Changes", style: TextStyle(color: Color.fromRGBO(185, 245, 216, 1),),),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Delete Device"),
                      content: Text("Are you sure you want to delete this device?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            deleteDevice();
                            Navigator.pop(context);
                          },
                          child: Text("Delete", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child:
                Text("Delete Device", style: TextStyle(color: Colors.white))
            )
        ],
        ),
      ),
      ),
    );
  }
}