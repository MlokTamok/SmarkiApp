import 'package:flutter/material.dart';
import 'package:smarkiapp2/account.dart';
import 'package:smarkiapp2/language.dart';
//import 'package:wheel_picker/wheel_picker.dart';


class Sterilizace extends StatefulWidget {
  final Map<String, String> device;
  const Sterilizace({Key? key, required this.device}) : super(key: key);

  @override
  _SterilizaceState createState() => _SterilizaceState();
}

class _SterilizaceState extends State<Sterilizace> {
  double _currentValue = 60;
  bool _switchValue1 = false;
  bool _switchValue2 = false;

  void _updateSwitchValue1(bool value) {
    setState(() {
      _switchValue1 = value;
      if (value) _switchValue2 = false;
    });
  }

  void _updateSwitchValue2(bool value) {
    setState(() {
      _switchValue2 = value;
      if (value) _switchValue1 = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, widget.device);
          },
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
        actions: [_buildPopupMenu()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSwitchRow("Ozone Sterilisation", _switchValue1, _updateSwitchValue1),
            _buildSwitchRow("UV Sterilisation", _switchValue2, _updateSwitchValue2),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Time setting in minutes or\naccording to the size of the room',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromRGBO(63, 80, 66, 1),
                ),
              ),
            ),
            _buildSlider(),
          ],
        ),
      ),
    );
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

  Widget _buildSlider() {
    return Column(
      children: [
        Slider(
          min: 30,
          max: 150,
          divisions: 4,
          label: '${_currentValue.toInt()} minutes',
          activeColor: Color.fromRGBO(107, 143, 113, 1),
          inactiveColor: Color.fromRGBO(185, 245, 216, 1),
          value: _currentValue,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
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

  
  

  Widget _buildPopupMenu() {
    return PopupMenuButton<String>(
      color: Color.fromRGBO(107, 143, 113, 1),
      icon: Icon(Icons.menu_rounded, color: Color.fromRGBO(63, 80, 66, 1)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey),
      ),
      onSelected: (String value) {
        if (value == 'account') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Account()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Language()),
          );
        }
      },
      itemBuilder: (context) => [
        _buildMenuItem("Language", Icons.language, 'language'),
        _buildMenuItem("Country", Icons.public, 'country'),
        _buildMenuItem("Time Zone", Icons.access_time, 'timezone'),
        _buildMenuItem("Account", Icons.account_box, 'account'),
      ],
    );
  }

  PopupMenuItem<String> _buildMenuItem(String title, IconData icon, String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          Text(title, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
  
}

