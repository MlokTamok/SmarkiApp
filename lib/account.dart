import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarkiapp2/passwordreset.dart';
import 'package:smarkiapp2/language.dart';
import 'package:smarkiapp2/warpper.dart';

void main() => runApp(Account());

class Account extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  signout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Warpper()), // Redirect to the Warpper
    (route) => false, // Remove all previous routes
  );
}



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
                onPressed: () => Navigator.pop(context), // Fixed
                icon: Icon(Icons.arrow_back_ios_new_rounded),
                color: Color.fromRGBO(63, 80, 66, 1),
              );
            },
          ),
          backgroundColor: const Color(0xFFAAD2BA),
          title: Text(
            "Account Settings",
            style: TextStyle(
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
                side: BorderSide(color: Colors.grey),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.language, color: Color.fromRGBO(255, 255, 255, 1)),
                      Text(
                        "Language",
                        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Language()),
                    );
                  },
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.public, color: Color.fromRGBO(255, 255, 255, 1)),
                      Text(
                        "Country",
                        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Language()),
                    );
                  },
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.access_time, color: Color.fromRGBO(255, 255, 255, 1)),
                      Text(
                        "Time Zone",
                        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Language()),
                    );
                  },
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.account_box, color: Color.fromRGBO(255, 255, 255, 1)),
                      Text(
                        "Account",
                        style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.account_circle,
                    color: const Color(0xFFAAD2BA),
                    size: 250,
                  ),
                  Text(
                    'Logged as:\n${user!.email}',
                    style: TextStyle(
                      color: const Color.fromRGBO(63, 80, 66, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: (20),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPassword()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Reset password',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () => signout(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Log out ',
                          style: TextStyle(color: Colors.red),
                        ),
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
