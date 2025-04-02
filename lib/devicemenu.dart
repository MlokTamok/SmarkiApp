import 'package:flutter/material.dart';
import 'package:smarkiapp2/editdevice.dart';
import 'package:smarkiapp2/sterilizace.dart';

class DeviceMenu extends StatelessWidget {
  final Map<String, String> device;

  DeviceMenu({required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAAD2BA),
        title: Text(device['name'] ?? 'Device Menu', style: TextStyle(
              color: const Color.fromRGBO(63, 80, 66, 1),
              fontWeight: FontWeight.bold,
            ),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromRGBO(63, 80, 66, 1),),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(1.0),
          child: SingleChildScrollView(
          child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsetsDirectional.fromSTEB(50, 50, 0, 0),
                child:
                SizedBox(
                  width: 130,
                  height: 130,
                  child: 
                ElevatedButton(onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sterilizace(device: device)
                  ),
                );
                },
                style: 
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lightbulb, size: 40, color: Color.fromRGBO(185, 245, 216, 1),),
                        Icon(Icons.air, size: 37, color: Color.fromRGBO(185, 245, 216, 1),),
                    ]
                    ),
                    Text('Lighting\n& Extraction', 
                    textAlign: TextAlign.center,
                    style: 
                    TextStyle(
                      color: Color.fromRGBO(185, 245, 216, 1),
                    ),)
                  ],
                )
                ),
                
                ),
                ),
                Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
                child:
                SizedBox(
                  width: 130,
                  height: 130,
                  child:
                ElevatedButton(onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sterilizace(device: device)
                    ),
                );
                },
                style: 
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.light, size: 55, color: Color.fromRGBO(185, 245, 216, 1)),
                    Text("Sterilization", 
                    style: 
                    TextStyle(
                      color: Color.fromRGBO(185, 245, 216, 1)
                    ),)
                  ],
                )
                )
                ),
                ),
              ]

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsetsDirectional.fromSTEB(50, 20, 0, 0),
                child:
                SizedBox(
                  width: 130,
                  height: 130,
                  child: 
                ElevatedButton(onPressed: (){
                  print('...');
                },
                style: 
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.soup_kitchen, size: 55, color: Color.fromRGBO(185, 245, 216, 1)),
                    Text("Cooking", 
                    style: 
                    TextStyle(
                      color: Color.fromRGBO(185, 245, 216, 1)
                    ),)
                  ],
                )
                )
                ),
                ),
                Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 20, 50, 0),
                child:
                SizedBox(
                  width: 130,
                  height: 130,
                  child: 
                ElevatedButton(onPressed: (){
                  print('...');
                },
                style: 
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.video_file, size: 55, color: Color.fromRGBO(185, 245, 216, 1)),
                    Text("Audio\n& Video", 
                    textAlign: TextAlign.center,
                    style: 
                    TextStyle(
                      color: Color.fromRGBO(185, 245, 216, 1)
                    ),)
                  ],
                )
                )
                ),
                ),
              ]

            ),Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsetsDirectional.fromSTEB(50, 20, 0, 0),
                child:
                SizedBox(
                  width: 130,
                  height: 130,
                  child: 
                ElevatedButton(onPressed: (){
                  print('...');
                },
                style: 
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home, size: 55, color: Color.fromRGBO(185, 245, 216, 1)),
                    Text("Household\nmanagement", 
                    textAlign: TextAlign.center,
                    style: 
                    TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(185, 245, 216, 1)
                    ),)
                  ],
                )
                )
                ),
                ),
                Padding(padding: EdgeInsetsDirectional.fromSTEB(0, 20, 50, 0),
                child:
                SizedBox(
                  width: 130,
                  height: 130,
                  child: 
                ElevatedButton(
                  onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDeviceScreen(device: device),
                    ),
                  );
                },
                style:
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, size: 55, color: Color.fromRGBO(185, 245, 216, 1)),
                    Text("Settings", 
                    style: 
                    TextStyle(
                      color: Color.fromRGBO(185, 245, 216, 1)
                    ),)
                  ],
                )
                )
                ),
                ),
              ]

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsetsDirectional.fromSTEB(60, 20, 0, 0),
                child:
                SizedBox(
                  width: 130,
                  height: 130,
                  child: 
                ElevatedButton(onPressed: (){
                  print('...');
                },
                style: 
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, size: 55, color: Color.fromRGBO(185, 245, 216, 1)),
                    Text("Security", 
                    style: 
                    TextStyle(
                      color: Color.fromRGBO(185, 245, 216, 1)
                    ),)
                  ],
                )
                )
                ),
                ),
              ]
            )
          ]
        )
      )
      )
      );
  }
}