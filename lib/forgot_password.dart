import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarkiapp2/login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController email=TextEditingController();

  reset() async {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          ),
      child: Scaffold(
        appBar: AppBar(
//          leading: Builder(
//            builder: (BuildContext context) {
//              return PopupMenuButton(
//                color: Color.fromRGBO(141, 179, 156, 1),
//                icon: Icon(Icons.language),
//                iconColor: Color.fromRGBO(141, 179, 156, 1),
//                shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10),
//              side: BorderSide(color: Colors.grey)
//            ),
//                itemBuilder:  (context) => [
//              PopupMenuItem(
//                child: 
//                Text("English"),
//                textStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)
//                ),
//                onTap: () {
//                  Navigator.pushReplacement(
//                    context,
//                    MaterialPageRoute(builder: (context) => ForgotPassword()),
//                  );
//                },
//                ),
//               PopupMenuItem(
//                child: 
//                Text("Čeština "),
//                textStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)
//                ),
//                onTap: () {
//                  Navigator.pushReplacement(
//                    context,
//                    MaterialPageRoute(builder: (context) => SignupCZ()),
//                  );
//                },
//                ),
//            ],
//            );
//            }
//          ),
     ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _sigup(context),
            ],
          ),
        ),
      ),
      );
  }

    _header(context){
      return Column(
        children: [
          Text(
            "Password Reset",///////////////////////////////////////////////////NADPIS
            style:
            TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(63, 80, 66, 1),
          ),
        ),
          Text("Please fill fields below to reset your password.",
          style: 
          TextStyle(
            color: Color.fromRGBO(63, 80, 66, 1)
            ),),/////////////////////////////////////////////PODNADPIS
        ],
      );
    }
  _inputField(context){
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [     
         TextField(
          controller: email,
           decoration: InputDecoration(
            labelText: 'Email',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none
                  ),
             fillColor: Color.fromRGBO(107, 143, 113, 0.1),
             filled: true,
             prefixIcon: Icon(Icons.mail_outline)
             ),
             keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 10),
     
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: (()=>reset()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(107, 143, 113, 1),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 16),
            ), 
            child: Text("Send Link",
            style: 
            TextStyle(
              color: Color.fromRGBO(185, 245, 216, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold),
            )
           )
        ],
     ),
   );
  }

  _sigup(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }, 
        child: Text("Back to Login",
        style: TextStyle(color: Color.fromRGBO(141, 179, 156, 1)),))
        )
      ],
    );
  }
}