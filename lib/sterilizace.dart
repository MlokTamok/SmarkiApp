import 'package:flutter/material.dart';
import 'package:smarkiapp2/account.dart';
import 'package:smarkiapp2/deices.dart';
import 'package:smarkiapp2/language.dart';


class Sterilizace extends StatefulWidget {
  const Sterilizace({Key? key}) :super(key: key);

  @override
  _Sterilizace createState() => _Sterilizace();
  }

class _Sterilizace extends State<Sterilizace> {
  
  double _currentValue = 60;
  bool _switchValue1 = false;
  bool _switchValue2 = false;

  void _updateSwitchValue1(bool value) {
    setState(() {
      _switchValue1 = value;
      if (value) {
        _switchValue2 = false;
      }
    });
  }

  void _updateSwitchValue2(bool value) {
    setState(() {
      _switchValue2 = value;
      if (value) {
        _switchValue1 = false;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 254, 254),
      ),
      home: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                child: 
                Text(
                  "Ozone Sterilisation",
                  style:
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(63, 80, 66, 1),
                  ),
                ),
              ),
                Switch(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 20, 0),
                  activeColor: Color.fromRGBO(107, 143, 113, 1),
                  inactiveTrackColor: Color.fromRGBO(185, 245, 216, 1), 
                  value: 
                _switchValue1, 
                onChanged: 
                _updateSwitchValue1),
           ],
           ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: 
                Text(
                  "UV Sterilisation",
                  style:
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(63, 80, 66, 1),
                  ),
                ),
              ),
                Switch(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                  activeColor: Color.fromRGBO(107, 143, 113, 1),
                  inactiveTrackColor: Color.fromRGBO(185, 245, 216, 1), 
                  value: 
                _switchValue2, 
                onChanged: 
                _updateSwitchValue2)
                
              ],
            ),
            Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
              child: Text(
              'Time setting in minutes or\naccording to the size of the room',
              textAlign: TextAlign.start,
              style:
              TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromRGBO(63, 80, 66, 1),
              ),
            ),
           ),
        ),
            SliderTheme(data: SliderTheme.of(context).copyWith(
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white
              )
            ), 
            child:
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
            child: 
            Column(
              children: [
                Slider(
                  min: 30,
                  max: 150,
                  divisions: 4,
                  label: '${_currentValue.toInt().toString()} minutes',
                  activeColor: Color.fromRGBO(107, 143, 113, 1),
                  inactiveColor: Color.fromRGBO(185, 245, 216, 1),
                  value: _currentValue, 
                  onChanged: (value){
                  setState(() {
                    _currentValue=value;
                  });
                },
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
                      child: Text(
                        'Small\n up to 20m²',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(
                          color: Color.fromRGBO(63, 80, 66, 1),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Medium\n20 to 50m²',
                      textAlign: TextAlign.center,
                      style:
                        TextStyle(
                          color: Color.fromRGBO(63, 80, 66, 1),
                        ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                      child: Text(
                        'Large\nover 50m²',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(
                          color: Color.fromRGBO(63, 80, 66, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
           ]
         ),
       )
     ),

          ],
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: (){
                Navigator.pushReplacement(
                  context,
                   MaterialPageRoute(builder: (context) => DevicesScreen()),
                 );
                },
                icon: Icon(Icons.arrow_back_ios_rounded),
                color: Color.fromRGBO(63, 80, 66, 1),
               );
            }
          ),
          backgroundColor: const Color(0xFFAAD2BA),
          title:
          Text("Sterilisation of the room", 
          style: 
          TextStyle(
            color: const Color.fromRGBO(63, 80, 66, 1),
          fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: Color.fromRGBO(107, 143, 113, 1),
            icon: Icon(Icons.menu_rounded),
            iconColor: Color.fromRGBO(63, 80, 66, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey)
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: 
                Row(
                  children: [
                    Icon(Icons.language, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text("Language", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Language()),
                  );
                },
                ),
               PopupMenuItem(
                child: 
                Row(
                  children: [
                    Icon(Icons.public, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text("Country", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Language()),
                  );
                },
                ),
              PopupMenuItem(
                child: 
                Row(
                  children: [
                    Icon(Icons.access_time, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text("Time Zone", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Language()),
                  );
                },
                ),
              PopupMenuItem(
                child: 
                Row(
                  children: [
                    Icon(Icons.account_box, color: Color.fromRGBO(255, 255, 255, 1)),
                    Text("Account", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  )
                ],
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Account()),
                  );
                },
                ),
        ],
     ),]
     ),
    ),
  );
  }
}