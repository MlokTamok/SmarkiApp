import 'package:flutter/material.dart';
import 'package:smarkiapp2/account.dart';
import 'package:smarkiapp2/deices.dart';
import 'package:smarkiapp2/CZ/language%20cz.dart';
import 'package:flag/flag.dart';

void main() => runApp(Language());


class Language extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 254, 254),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: (){
                Navigator.pushReplacement(
                  context,
                   MaterialPageRoute(builder: (context) => Devices_Screen()),
                 );
                },
                icon: Icon(Icons.home),
                color: Color.fromRGBO(63, 80, 66, 1),
               );
            }
          ),
          backgroundColor: const Color(0xFFAAD2BA),
          title:
          Text("Language Settings", 
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
     ),
        ],
     ),
     body:
     Column(
      children: [Padding(padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0)),
        Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(padding: EdgeInsetsDirectional.fromSTEB(50, 50, 0, 0),
                child:
                SizedBox(
                  width: 130,
                  height: 130,
                  child: 
                ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CZLanguage()),///////////////
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
                    Flag.fromCode(FlagsCode.CZ, width: 50, height: 50,),
                    Text('Český Jazyk\nCZ', 
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
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Language()),
                );
                },
                style: 
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  backgroundColor: Color.fromRGBO(107, 143, 113, 0.3),
                ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flag.fromCode(FlagsCode.US, width: 50, height: 50,),
                    Text('English\nEN',
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
          ),
        ]
      )
    ),
    );
  }
}

