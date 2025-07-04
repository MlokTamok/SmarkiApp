import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Security extends StatefulWidget {
  final String deviceId;
  final Map<String, dynamic> deviceData;

  const Security({
    Key? key,
    required this.deviceId,
    required this.deviceData,
  }) : super(key: key);

  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  double _Slider = 2;
  bool _switchValue1 = false;
  bool _isSterilisationActive = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    FirebaseFirestore.instance
        .collection("App-Security")
        .doc(widget.deviceId)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _switchValue1 = data['Random off/on'] ?? false;
          _isSterilisationActive = data['Start'] ?? false;
          _Slider = (data['Slider'] ?? 2).toDouble();
        });
      }
    }).catchError((e) {
      print("Error loading data: $e");
    });
  }

  void _saveData() {
    FirebaseFirestore.instance
        .collection("App-Security")
        .doc(widget.deviceId)
        .set({
      'Random off/on': _switchValue1,
      'Start': _isSterilisationActive,
      'Slider': _Slider,
    }, SetOptions(merge: true)).catchError((e) {
      print("Error saving data: $e");
    });
  }

  void _updateSwitchValue3(bool value) {
    setState(() {
      _switchValue1 = value;
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

  Widget _buildSliderStart() {
    return Column(
      children: [
        Slider(
          min: 1,
          max: 5,
          divisions: 4,
          label: '${_Slider.toInt()}',
          activeColor: _switchValue1
              ? Color.fromRGBO(107, 143, 113, 1)
              : Color.fromRGBO(185, 245, 216, 1),
          inactiveColor: Color.fromRGBO(185, 245, 216, 1),
          value: _Slider,
          onChanged: _switchValue1
              ? (value) {
                  setState(() {
                    _Slider = value;
                  });
                  _saveData();
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildStartButton(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(63, 80, 66, 1),
          ),
        ),
        SizedBox(
          width: 80,
          height: 65,
          child: ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Secutity')
                  .doc(widget.deviceId)
                  .set({'Start': true}, SetOptions(merge: true));
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Color.fromRGBO(107, 143, 113, 1),
            ),
            child: Text(
              'Start',
              style: TextStyle(color: Color.fromRGBO(185, 245, 216, 1)),
            ),
          ),
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
          "Security",
          style: TextStyle(
            color: Color.fromRGBO(63, 80, 66, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){FirebaseFirestore.instance
        .collection('Secutity')
        .doc(widget.deviceId)
        .set({'Start': false}, SetOptions(merge: true))
        .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
              'Security has been stopped!'
            )),
          );
        })
        .catchError((e) {
          print("Error: $e");
        });}, 
          icon: Icon(Icons.stop_circle))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSwitchRow("The light randomly turns on and off", _switchValue1, _updateSwitchValue3),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Start of security',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromRGBO(63, 80, 66, 1),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'After leaving in minutes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(63, 80, 66, 1),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildSliderStart(),
              SizedBox(height: 30),
              _buildStartButton("Start the security"),
            ],
          ),
        ),
      ),
    );
  }
}
