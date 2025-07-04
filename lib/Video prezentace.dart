import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AudioAndVideoScreen extends StatefulWidget {
  final String deviceId;

  const AudioAndVideoScreen({
    super.key,
    required this.deviceId,
  });

  @override
  State<AudioAndVideoScreen> createState() => _AudioAndVideoScreenState();
}

class _AudioAndVideoScreenState extends State<AudioAndVideoScreen> {
  bool startupTime = false;
  bool uvSterilisation = false;
  bool afterLeaving = false;
  bool startTime = false;
  bool repeat = false;

  TimeOfDay selectedTime = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay selectedTime2 = const TimeOfDay(hour: 12, minute: 0);

  final TextEditingController videoIdController = TextEditingController();
  String videoId = 'aMMlbqf30Mo';
  late YoutubePlayerController youtubeController;

  @override
  void initState() {
    super.initState();
    youtubeController = YoutubePlayerController.fromVideoId(
      videoId: videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        showControls: true,
      ),
    );
    _loadData();
  }

  void _loadData() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('(App)Audio And Video').doc(widget.deviceId).get();
      if (!doc.exists) return;

      final data = doc.data()!;
      setState(() {
        startupTime = data['Start-up time'] ?? false;
        uvSterilisation = data['UVSterilisation'] ?? false;
        afterLeaving = data['AfterLeaving'] ?? false;
        startTime = data['StartTime'] ?? false;
        repeat = data['Repeat'] ?? false;

        selectedTime = TimeOfDay(
          hour: data['selectedTimeHour'] ?? 0,
          minute: data['selectedTimeMinute'] ?? 0,
        );
        selectedTime2 = TimeOfDay(
          hour: data['selectedTimeHour2'] ?? 0,
          minute: data['selectedTimeMinute2'] ?? 0,
        );

        videoId = data['videoId'] ?? videoId;
        videoIdController.text = videoId;
        youtubeController.loadVideoById(videoId: videoId);
      });
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
  }

  void _saveData() {
    FirebaseFirestore.instance.collection('(App)Audio And Video').doc(widget.deviceId).set({
      'Start-up time': startupTime,
      'UVSterilisation': uvSterilisation,
      'AfterLeaving': afterLeaving,
      'StartTime': startTime,
      'Repeat': repeat,
      'selectedTimeHour': selectedTime.hour,
      'selectedTimeMinute': selectedTime.minute,
      'selectedTimeHour2': selectedTime2.hour,
      'selectedTimeMinute2': selectedTime2.minute,
      'videoId': videoId,
    });
  }

  Future<void> _pickTime({required bool isFirst}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isFirst ? selectedTime : selectedTime2,
    );
    if (picked != null) {
      setState(() {
        if (isFirst) {
          selectedTime = picked;
        } else {
          selectedTime2 = picked;
        }
      });
      _saveData();
    }
  }

  Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(63, 80, 66, 1),
        ),
      ),
      value: value,
      activeColor: const Color.fromRGBO(107, 143, 113, 1),
      inactiveTrackColor: const Color.fromRGBO(185, 245, 216, 1),
      onChanged: (val) {
        onChanged(val);
        _saveData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: const Color.fromRGBO(63, 80, 66, 1)),
        backgroundColor: const Color(0xFFAAD2BA),
        centerTitle: true,
        title: const Text(
          'Audio & Video',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(63, 80, 66, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSwitch('Starting after person detection', startupTime, (val) {
              setState(() {
                startupTime = val;
                if (val) uvSterilisation = false;
              });
            }),
            ElevatedButton(
              onPressed: startupTime ? () => _pickTime(isFirst: true) : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(107, 143, 113, 1),
                disabledBackgroundColor: const Color.fromRGBO(185, 245, 216, 1),
              ),
              child: Text(
                'Select Time: ${selectedTime.format(context)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            _buildSwitch('Re-run', uvSterilisation, (val) {
              setState(() {
                uvSterilisation = val;
                if (val) startupTime = false;
              });
            }),
            const SizedBox(height: 10),
            _buildSwitch('Add another time', afterLeaving, (val) {
              setState(() => afterLeaving = val);
            }),
            const SizedBox(height: 10),
            TextField(
              controller: videoIdController,
              decoration: InputDecoration(
                labelText: 'Playback source',
                filled: true,
                fillColor: const Color.fromRGBO(107, 143, 113, 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (val) {
                setState(() {
                  videoId = val;
                  youtubeController.loadVideoById(videoId: videoId);
                });
                _saveData();
              },
            ),
            const SizedBox(height: 16),
            YoutubePlayer(
              controller: youtubeController,
              aspectRatio: 16 / 9,
            ),
            const SizedBox(height: 10),
            _buildSwitch('Next', startTime, (val) {
              setState(() => startTime = val);
            }),
            const SizedBox(height: 10),
            TextField(
              enabled: startTime,
              decoration: InputDecoration(
                labelText: 'Next sequences',
                filled: true,
                fillColor: const Color.fromRGBO(107, 143, 113, 0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
