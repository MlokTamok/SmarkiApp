import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddDeviceFlowScreen extends StatefulWidget {
  const AddDeviceFlowScreen({Key? key}) : super(key: key);

  @override
  State<AddDeviceFlowScreen> createState() => _AddDeviceFlowScreenState();
}

class _AddDeviceFlowScreenState extends State<AddDeviceFlowScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _townController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _housenController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _NameandSurnameController = TextEditingController();
  final TextEditingController _PhoneNumberController = TextEditingController();

  String? _selectedDeviceVersion;
  final List<String> _deviceVersions = ['SMARKI DK 90', 'SMARKI DK 60', 'SMARKI DS 90'];

  String? _selectedDeviceType;
  final List<String> _deviceTypes = ['Kitchen hood', 'Air purifier', 'Air conditioner'];

  bool isCodeEntered = false;
  String scannedCode = '';
  String? documentId;

  Future<void> _saveCode() async {
    final code = _codeController.text.trim();
    final user = _auth.currentUser;

    if (code.isEmpty || user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a code and make sure you are logged in.')),
      );
      return;
    }

    try {
      final docRef = await _firestore.collection('Device').add({
        'code': code,
        'user_id': user.uid,
        'user_email': user.email,
        'Name': '',
        'Device Version': '',
        'Device Type': '',
        'Location': '',
        'Town': '',
        'Street': '',
        'House Number': '',
        'Floor': '',
        'Name and Surname': '',
        'Phone Number': '',
        'created_at': FieldValue.serverTimestamp(),
      });

      setState(() {
        scannedCode = code;
        isCodeEntered = true;
        documentId = docRef.id;
      });

      final snapshot = await docRef.get();
      final data = snapshot.data();
      if (data != null) {
        _nameController.text = data['Name'] ?? '';
        _selectedDeviceVersion = data['Device Version'] ?? null;
        _selectedDeviceType = data['Device Type'] ?? null;
        _locationController.text = data['Location'] ?? '';
        _townController.text = data['Town'] ?? '';
        _streetController.text = data['Street'] ?? '';
        _housenController.text = data['House Number'] ?? '';
        _floorController.text = data['Floor'] ?? '';
        _NameandSurnameController.text = data['Name and Surname'] ?? '';
        _PhoneNumberController.text = data['Phone Number'] ?? '';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save code: $e')),
      );
    }
  }

  Future<void> _saveDeviceDetails() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final location = _locationController.text.trim();
      final town = _townController.text.trim();
      final street = _streetController.text.trim();
      final house_n = _housenController.text.trim();
      final floor = _floorController.text.trim();
      final user = _auth.currentUser;
      final nameandnurname = _NameandSurnameController.text.trim();
      final phone_n = _PhoneNumberController.text.trim();

      if (name.isEmpty || _selectedDeviceVersion == null || _selectedDeviceType == null ||
          location.isEmpty || town.isEmpty || street.isEmpty || house_n.isEmpty || user == null || documentId == null || nameandnurname == null || phone_n == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
        return;
      }

      try {
        await _firestore.collection('Device').doc(documentId).update({
          'Name': name,
          'Device Version': _selectedDeviceVersion,
          'Device Type': _selectedDeviceType,
          'Location': location,
          'Town': town,
          'Street': street,
          'House Number': house_n,
          'Floor': floor,
          'Name and Surname': nameandnurname,
          'Phone Number': phone_n,
          'updated_at': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device added successfully!')),
        );
        documentId = null; 
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update device: $e')),
        );
      }
    }
  }

  Future<bool> _onWillPop() async {
    if (isCodeEntered && documentId != null) {
      try {
        await _firestore.collection('Device').doc(documentId).delete();
      } catch (e) {}
    }
    return true;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    _townController.dispose();
    _streetController.dispose();
    _housenController.dispose();
    _floorController.dispose();
    _NameandSurnameController.dispose();
    _PhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFAAD2BA),
          title: const Text(
            "Add Device",
            style: TextStyle(
              color: Color.fromRGBO(63, 80, 66, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            color: Color.fromRGBO(63, 80, 66, 1),
            onPressed: () async {
              bool shouldPop = await _onWillPop();
              if (shouldPop) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: isCodeEntered
              ? _buildDeviceForm()
              : _buildCodeInput(),
        ),
      ),
    );
  }

  Widget _buildCodeInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _codeController,
          decoration: InputDecoration(
            labelText: 'Code',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromRGBO(107, 143, 113, 0.1),
            filled: true,
            prefixIcon: Icon(Icons.qr_code_scanner),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _saveCode,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(107, 143, 113, 1),
            shape: StadiumBorder(),
          ),
          child: const Text("Next",
            style: TextStyle(
              color: Color.fromRGBO(185, 245, 216, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeviceForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text('Code: $scannedCode', style: TextStyle(fontSize: 18, color: Color.fromRGBO(63, 80, 66, 1))),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Device',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromRGBO(63, 80, 66, 1),
                  ),
                ),
              ),
            SizedBox(height: 10,),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Device Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Device Name is required';
                }
                return null;
              },
            ),
//            SizedBox(height: 10),
//            DropdownButtonFormField<String>(
//              value: _selectedDeviceType,
//              decoration: InputDecoration(
//                labelText: 'Select Device Type',
//                border: OutlineInputBorder(
//                  borderRadius: BorderRadius.circular(18),
//                  borderSide: BorderSide.none,
//                ),
//                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
//                filled: true,
//              ),
//              items: _deviceTypes.map((type) {
//                return DropdownMenuItem(
//                  value: type,
//                  child: Text(type),
//                );
//              }).toList(),
//              onChanged: (value) {
//                setState(() {
//                  _selectedDeviceType = value;
//                });
//              },
//             validator: (value) {
//                if (value == null) {
//                  return 'Device type is required';
//                }
//                return null;
//              },
//            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedDeviceVersion,
              decoration: InputDecoration(
                labelText: 'Select Device Version',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              items: _deviceVersions.map((version) {
                return DropdownMenuItem(
                  value: version,
                  child: Text(version),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDeviceVersion = value;
                });
              },
             validator: (value) {
                if (value == null) {
                  return 'Device version is required';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Device Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Location is required';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _townController,
              decoration: InputDecoration(
                labelText: 'Town',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Town is required';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _streetController,
              decoration: InputDecoration(
                labelText: 'Street',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Street is required';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _housenController,
              decoration: InputDecoration(
                labelText: 'House Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'House Number is required';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _floorController,
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
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'User',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromRGBO(63, 80, 66, 1),
                  ),
                ),
              ),
            SizedBox(height: 10),
            TextFormField(
              controller: _NameandSurnameController,
              decoration: InputDecoration(
                labelText: 'Name and Surname',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name and Surname is required';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _PhoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                filled: true,
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone Number is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveDeviceDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                shape: StadiumBorder(),
              ),
              child: const Text("Save Device",
                style: TextStyle(
                  color: Color.fromRGBO(185, 245, 216, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
