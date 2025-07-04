import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OsvetleniOdsavani extends StatefulWidget {
  final String deviceId;
  final Map<String, dynamic> deviceData;

  const OsvetleniOdsavani({
    Key? key,
    required this.deviceId,
    required this.deviceData,
  }) : super(key: key);

  @override
  _OsvetleniOdsavaniState createState() => _OsvetleniOdsavaniState();
}

class _OsvetleniOdsavaniState extends State<OsvetleniOdsavani> {
  bool _switchValue1 = false;
  bool _switchValue2 = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    FirebaseFirestore.instance
        .collection("App-Lighting & Extraction")
        .doc(widget.deviceId)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _switchValue1 = data['On/Off Light'] ?? false;
          _switchValue2 = data['On/Off Extraction'] ?? false;
        });
      }
    }).catchError((e) {
      print("Error loading data: $e");
    });
  }

  void _saveData() {
    FirebaseFirestore.instance
        .collection("App-Lighting & Extraction")
        .doc(widget.deviceId)
        .set({
      'On/Off Light': _switchValue1,
      'On/Off Extraction': _switchValue2,
    }, SetOptions(merge: true)).catchError((e) {
      print("Error saving data: $e");
    });
  }

  void _updateSwitchValue1(bool value) {
    setState(() {
      _switchValue1 = value;
    });
    _saveData();
  }

  void _updateSwitchValue2(bool value) {
    setState(() {
      _switchValue2 = value;
    });
    _saveData();
  }


  Widget _buildSwitchRow(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(63, 80, 66, 1),
          ),
        ),
        Switch(
          activeColor: Color.fromRGBO(107, 143, 113, 1),
          inactiveTrackColor: Color.fromRGBO(185, 245, 216, 1),
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Color.fromRGBO(63, 80, 66, 1),
        ),
        backgroundColor: Color(0xFFAAD2BA),
        title: Text(
          "Lighting & Extraction",
          style: TextStyle(
            color: Color.fromRGBO(63, 80, 66, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSwitchRow("On/Off Light", _switchValue1, _updateSwitchValue1),
              _buildSwitchRow("On/Off Extraction", _switchValue2, _updateSwitchValue2),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
