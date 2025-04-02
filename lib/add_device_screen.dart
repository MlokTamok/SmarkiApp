import 'package:flutter/material.dart';

class AddDeviceScreen extends StatefulWidget {
  final Function(Map<String, String>) onDeviceAdded;

  const AddDeviceScreen({super.key, required this.onDeviceAdded});

  @override
  // ignore: library_private_types_in_public_api
  _AddDeviceScreenState createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final _formKey = GlobalKey<FormState>();

  final _deviceNameController = TextEditingController();
  final _deviceLocationController = TextEditingController();
  final _deviceTownController = TextEditingController();
  final _deviceStreetController = TextEditingController();
  final _deviceHouseNumberController = TextEditingController();
  final _deviceFloorController = TextEditingController();

  String? _deviceTypeController;
  final List<String> _deviceTypes = ['Kitchen hood', 'Air purifier', 'Air Conditioning'];

  String? _deviceVersionController;
  final List<String> _deviceVersions = ['SMARKI DK 90', 'SMARKI DK 60', 'SMARKI DS 90'];

  void saveDevice() {
    if (_formKey.currentState!.validate()) {
      Map<String, String> newDevice = {
        'name': _deviceNameController.text,
        'type': _deviceTypeController ?? 'Unknown',
        'version': _deviceVersionController ?? 'Unknown',
        'location': _deviceLocationController.text,
        'town': _deviceTownController.text,
        'street': _deviceStreetController.text,
        'housenumber': _deviceHouseNumberController.text,
        'floor': _deviceFloorController.text,
      };

      widget.onDeviceAdded(newDevice);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAAD2BA),
        title: Text(
          'New Device',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(63, 80, 66, 1)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromRGBO(63, 80, 66, 1)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _deviceNameController,
                decoration: InputDecoration(
                  labelText: "Device Name",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Device name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              DropdownButtonFormField<String>(
                value: _deviceTypeController,
                hint: Text('Select Device Type'),
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                  filled: true
                ),
                items: _deviceTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _deviceTypeController = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please select a device type";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),

              DropdownButtonFormField<String>(
                value: _deviceVersionController,
                hint: Text('Select Device Version'),
                isExpanded: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                  filled: true
                ),
                items: _deviceVersions.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _deviceVersionController = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return "Please select a device version";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                controller: _deviceLocationController,
                decoration: InputDecoration(
                  labelText: "Device Location",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Device location is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                controller: _deviceTownController,
                decoration: InputDecoration(
                  labelText: "Town",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Town is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                controller: _deviceStreetController,
                decoration: InputDecoration(
                  labelText: "Street",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Street is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                controller: _deviceHouseNumberController,
                decoration: InputDecoration(
                  labelText: "House Number",
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "House number is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 12,),
              TextFormField(
                controller: _deviceFloorController,
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
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: saveDevice,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child: 
                Text("Save Device", style: TextStyle(color: Color.fromRGBO(185, 245, 216, 1),),),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}
