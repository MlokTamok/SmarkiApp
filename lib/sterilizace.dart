import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sterilizace extends StatefulWidget {
  final String deviceId;
  final Map<String, dynamic> deviceData;

  const Sterilizace({
    Key? key,
    required this.deviceId,
    required this.deviceData,
  }) : super(key: key);

  @override
  _SterilizaceState createState() => _SterilizaceState();
}

class _SterilizaceState extends State<Sterilizace> {
  double _StartcurrentValue = 2;
  double _TimecurrentValue = 60;
  bool _switchValue1 = false;
  bool _switchValue2 = false;
  bool _switchValue3 = false;
  bool _switchValue4 = false;
  bool _switchValue5 = false;
  bool _START = false;
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0); 
  int _days = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    FirebaseFirestore.instance
        .collection('Sterilisation')
        .doc(widget.deviceId)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        setState(() {
          final data = docSnapshot.data() as Map<String, dynamic>;
          _switchValue1 = data['OzoneSterilisation'] ?? false;
          _switchValue2 = data['UVSterilisation'] ?? false;
          _switchValue3 = data['AfterLeaving'] ?? false;
          _switchValue4 = data['StartTime'] ?? false;
          _switchValue5 = data['Repeat'] ?? false;
          _START = data['START'] ?? false;
          _StartcurrentValue = data['StartcurrentValue'] ?? 2;
          _TimecurrentValue = data['TimecurrentValue'] ?? 60;
          _selectedTime = TimeOfDay(
            hour: data['selectedTimeHour'] ?? 0,
            minute: data['selectedTimeMinute'] ?? 0,
          );
          _days = data['days'] ?? 0;
        });
      }
    }).catchError((e) {
      print("Error loading data: $e");
    });
  }

  void _saveData() {
    FirebaseFirestore.instance.collection('Sterilisation').doc(widget.deviceId).set({
      'OzoneSterilisation': _switchValue1,
      'UVSterilisation': _switchValue2,
      'AfterLeaving': _switchValue3,
      'StartTime': _switchValue4,
      'Repeat': _switchValue5,
      'START': _START,
      'StartcurrentValue': _StartcurrentValue,
      'TimecurrentValue': _TimecurrentValue,
      'selectedTimeHour': _selectedTime.hour,
      'selectedTimeMinute': _selectedTime.minute,
      'days': _days,
    }).catchError((e) {
      print("Error saving data: $e");
    });
  }

  void _updateSwitchValue1(bool value) {
    setState(() {
      _switchValue1 = value;
      if (value) _switchValue2 = false;
    });
    _saveData();
  }

  void _updateSwitchValue2(bool value) {
    setState(() {
      _switchValue2 = value;
      if (value) _switchValue1 = false;
    });
    _saveData();
  }

  void _updateSwitchValue3(bool value) {
    setState(() {
      _switchValue3 = value;
    });
    _saveData();
  }

  void _updateSwitchValue4(bool value) {
    setState(() {
      _switchValue4 = value;
    });
    _saveData();
  }

  void _updateSwitchValue5(bool value) {
    setState(() {
      _switchValue5 = value;
    });
    _saveData();
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      _saveData();
    }
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

  Widget _buildSliderTime() {
    return Column(
      children: [
        Slider(
          min: 30,
          max: 150,
          divisions: 4,
          label: '${_TimecurrentValue.toInt()} minutes',
          activeColor: Color.fromRGBO(107, 143, 113, 1),
          inactiveColor: Color.fromRGBO(185, 245, 216, 1),
          value: _TimecurrentValue,
          onChanged: (value) {
            setState(() {
              _TimecurrentValue = value;
            });
            _saveData();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Small\n up to 20m²', textAlign: TextAlign.center),
            Text('Medium\n20 to 50m²', textAlign: TextAlign.center),
            Text('Large\nover 50m²', textAlign: TextAlign.center),
          ],
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
          label: '${_StartcurrentValue.toInt()}',
          activeColor: _switchValue3
              ? Color.fromRGBO(107, 143, 113, 1)
              : Color.fromRGBO(185, 245, 216, 1),
          inactiveColor: Color.fromRGBO(185, 245, 216, 1),
          value: _StartcurrentValue,
          onChanged: _switchValue3
              ? (value) {
                  setState(() {
                    _StartcurrentValue = value;
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
        .collection('Sterilisation')
        .doc(widget.deviceId)
        .set({'START': true}, SetOptions(merge: true))
        .then((_) {
          int minutes = _switchValue3 ? _StartcurrentValue.toInt() : 0;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
              minutes > 0
                ? 'Sterilisation will start in $minutes minutes!'
                : 'Sterilisation started immediately!',
            )),
          );
        })
        .catchError((e) {
          print("Error: $e");
        });
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

  Widget _buildDayCounter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Center(
          child: Text(
            'Repeat every (days):',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromRGBO(63, 80, 66, 1),
            ),
          ),
        ),
        SizedBox(height: 10),
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: _days > 0
                    ? () => setState(() {
                        _days--;
                        _saveData();
                      })
                    : null,
              ),
              Text('$_days', style: TextStyle(fontSize: 20)),
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.green),
                onPressed: () => setState(() {
                  _days++;
                  _saveData();
                }),
              ),
            ],
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
          "Sterilisation of the room",
          style: TextStyle(
            color: Color.fromRGBO(63, 80, 66, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){FirebaseFirestore.instance
        .collection('Sterilisation')
        .doc(widget.deviceId)
        .set({'START': false}, SetOptions(merge: true))
        .then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
              'Sterilisation has been stopped!'
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
              _buildSwitchRow("Ozone Sterilisation", _switchValue1, _updateSwitchValue1),
              _buildSwitchRow("UV Sterilisation", _switchValue2, _updateSwitchValue2),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Sterilisation Duration by\nminutes or room size',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromRGBO(63, 80, 66, 1),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildSliderTime(),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Start of the Sterilisation:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromRGBO(63, 80, 66, 1),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _buildSwitchRow("After leaving in minutes", _switchValue3, _updateSwitchValue3),
              SizedBox(height: 10),
              _buildSliderStart(),
              SizedBox(height: 30),
              _buildStartButton("Start the sterilization"),
              SizedBox(height: 30),
              _buildSwitchRow("Sterilization start time setting", _switchValue4, _updateSwitchValue4),
              ElevatedButton(
                onPressed: _switchValue4 ? () => _selectTime(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                  disabledBackgroundColor: Color.fromRGBO(185, 245, 216, 1),
                ),
                child: Text(
                  'Select Time: ${_selectedTime.format(context)}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              _buildSwitchRow("Repetition of sterilisation in days", _switchValue5, _updateSwitchValue5),
              if (_switchValue5) _buildDayCounter(),
            ],
          ),
        ),
      ),
    );
  }
}
