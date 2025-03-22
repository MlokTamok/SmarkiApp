import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarkiapp2/deices.dart';
import 'package:smarkiapp2/login.dart';
import 'package:smarkiapp2/verifyemail.dart';

class Warpper extends StatefulWidget {
  const Warpper({super.key});

  @override
  State<Warpper> createState() => _WarpperState();
}

class _WarpperState extends State<Warpper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          if (snapshot.hasData){
            print(snapshot.data);
            if(snapshot.data!.emailVerified){
              return DevicesScreen();
            }else{
              return Verify();
            }
          }else{
            return LoginPage();
          }
        }
        ),
    );
  }
}