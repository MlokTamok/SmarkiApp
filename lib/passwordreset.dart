import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarkiapp2/account.dart';

void main() => runApp(ResetPassword());

class ResetPassword extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
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
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Account()),
                  );
                },
                icon: Icon(Icons.arrow_back_ios_rounded),
                color: Color.fromRGBO(63, 80, 66, 1),
              );
            },
          ),
          backgroundColor: const Color(0xFFAAD2BA),
          title: Text(
            "Reset Password Settings",
            style: TextStyle(
              color: const Color.fromRGBO(63, 80, 66, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _resetButton(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          'Resetting password for:\n${user!.email}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(63, 80, 66, 1),
          ),
        ),
        Text(
          "Click the button below to reset your password.",
          style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1)),
        ),
      ],
    );
  }

  _resetButton(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: (() => reset()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(107, 143, 113, 1),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              "Send Link",
              style: TextStyle(
                color: Color.fromRGBO(185, 245, 216, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
