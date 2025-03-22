import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarkiapp2/warpper.dart';
import 'package:smarkiapp2/login.dart'; 

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  @override
  void initState() {
    sendverifylink();
    super.initState();
  }

  sendverifylink() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value) => {
      Get.snackbar('Link Sent', 'A link has been sent to your email', margin: EdgeInsets.all(30))
    });
  }

  reload() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.reload(); 
    if (user.emailVerified) {
      Get.offAll(Warpper());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please check your mail first.")),
      );
    }
  }

  goBack() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
        centerTitle: true,
        leading: IconButton(  
          icon: Icon(Icons.arrow_back_ios_rounded, color: Color.fromRGBO(63, 80, 66, 1),),
          onPressed: goBack,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0), 
              child: Text(
                'Open your mail and click on the link provided to verify your email then click on the button below.',
                textAlign: TextAlign.center, 
                style: TextStyle(fontSize: 23),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => reload(),
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }
}
