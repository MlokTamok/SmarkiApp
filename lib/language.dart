import 'package:flutter/material.dart';
import 'package:smarkiapp2/CZ/language_cz.dart';
import 'package:smarkiapp2/account.dart';
import 'package:flag/flag.dart';

class Language extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromRGBO(63, 80, 66, 1)),
          onPressed: () => Navigator.pop(context), // Fixed
        ),
        backgroundColor: const Color(0xFFAAD2BA),
        title: Text(
          "Language Settings",
          style: TextStyle(
            color: Color.fromRGBO(63, 80, 66, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            color: Color.fromRGBO(107, 143, 113, 1),
            icon: Icon(Icons.menu_rounded, color: Color.fromRGBO(63, 80, 66, 1)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.language, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Language", style: TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () => Navigator.pop(context), // Just closes the menu
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.public, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Country", style: TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () => Navigator.pop(context),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Time Zone", style: TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () => Navigator.pop(context),
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.account_box, color: Colors.white),
                    SizedBox(width: 10),
                    Text("Account", style: TextStyle(color: Colors.white)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(50, 50, 0, 0),
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CZLanguage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color.fromRGBO(107, 143, 113, 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flag.fromCode(FlagsCode.CZ, width: 50, height: 50),
                        Text(
                          'Český Jazyk\nCZ',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color.fromRGBO(185, 245, 216, 1)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 50, 0),
                child: SizedBox(
                  width: 130,
                  height: 130,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color.fromRGBO(107, 143, 113, 0.3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flag.fromCode(FlagsCode.US, width: 50, height: 50),
                        Text(
                          'English\nEN',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color.fromRGBO(185, 245, 216, 1)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
