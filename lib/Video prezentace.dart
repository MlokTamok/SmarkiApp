import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AudioAndVideo extends StatefulWidget {
  final String deviceId;
  final Map<String, dynamic> deviceData;

  const AudioAndVideo({
    Key? key,
    required this.deviceId,
    required this.deviceData,
  }) : super(key: key);

  @override
  _AudioAndVideoState createState() => _AudioAndVideoState();
}

class _AudioAndVideoState extends State<AudioAndVideo> {
  bool _StartUpTime = false;
  bool _switchValue2 = false;
  bool _switchValue3 = false;
  bool _switchValue4 = false;
  bool _switchValue5 = false;
  TimeOfDay _selectedTime = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _selectedTime2 = TimeOfDay(hour: 12, minute: 0);

  late YoutubePlayerController _controller;
  final TextEditingController _videoIdController = TextEditingController();
  String _videoId = 'aMMlbqf30Mo'; // Default fallback

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: _videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        showControls: true,
      ),
    );
    _loadData();
  }

  void _loadData() {
    FirebaseFirestore.instance
        .collection('Audio And Video')
        .doc(widget.deviceId)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _StartUpTime = data['Start-up time'] ?? false;
          _switchValue2 = data['UVSterilisation'] ?? false;
          _switchValue3 = data['AfterLeaving'] ?? false;
          _switchValue4 = data['StartTime'] ?? false;
          _switchValue5 = data['Repeat'] ?? false;
          _selectedTime = TimeOfDay(
            hour: data['selectedTimeHour'] ?? 0,
            minute: data['selectedTimeMinute'] ?? 0,
          );
          _selectedTime2 = TimeOfDay(
            hour: data['selectedTimeHour2'] ?? 0,
            minute: data['selectedTimeMinute2'] ?? 0,
          );
          _videoId = data['videoId'] ?? _videoId;
          _videoIdController.text = _videoId;
          _controller.loadVideoById(videoId: _videoId);
        });
      }
    }).catchError((e) {
      print("Error loading data: $e");
    });
  }

  void _saveData() {
    FirebaseFirestore.instance.collection('Audio And Video').doc(widget.deviceId).set({
      'Start-up time': _StartUpTime,
      'UVSterilisation': _switchValue2,
      'AfterLeaving': _switchValue3,
      'StartTime': _switchValue4,
      'Repeat': _switchValue5,
      'selectedTimeHour': _selectedTime.hour,
      'selectedTimeMinute': _selectedTime.minute,
      'selectedTimeHour2': _selectedTime2.hour,
      'selectedTimeMinute2': _selectedTime2.minute,
      'videoId': _videoId,
    }).catchError((e) {
      print("Error saving data: $e");
    });
  }

  void _updateSwitchValue1(bool value) {
    setState(() {
      _StartUpTime = value;
      if (value) _switchValue2 = false;
    });
    _saveData();
  }

  void _updateSwitchValue2(bool value) {
    setState(() {
      _switchValue2 = value;
      if (value) _StartUpTime = false;
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
          "Audio & Video",
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
              _buildSwitchRow("Starting after person detection", _StartUpTime, _updateSwitchValue1),
              ElevatedButton(
                onPressed: _StartUpTime ? () => _selectTime(context) : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                  disabledBackgroundColor: Color.fromRGBO(185, 245, 216, 1),
                ),
                child: Text(
                  'Select Time: ${_selectedTime.format(context)}',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              _buildSwitchRow("Re-run", _switchValue2, _updateSwitchValue2),
              SizedBox(height: 10),
              _buildSwitchRow("Add another time", _switchValue3, _updateSwitchValue3),
              SizedBox(height: 10),
              TextField(
                controller: _videoIdController,
                decoration: InputDecoration(
                  labelText: 'Playback source',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                  filled: true,
                ),
                onSubmitted: (value) {
                  setState(() {
                    _videoId = value;
                    _controller.loadVideoById(videoId: _videoId);
                  });
                  _saveData();
                },
              ),
              SizedBox(height: 16),
              YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
              SizedBox(height: 10),
              _buildSwitchRow("Next", _switchValue4, _updateSwitchValue4),
              SizedBox(height: 10),
              TextField(
                enabled: _switchValue4,
                decoration: InputDecoration(
                  labelText: 'Next sequences',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color.fromRGBO(107, 143, 113, 0.1),
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
