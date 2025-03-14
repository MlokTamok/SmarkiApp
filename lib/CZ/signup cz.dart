import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarkiapp2/CZ/login%20cz.dart';
import 'package:smarkiapp2/signup.dart';
import 'package:smarkiapp2/warpper.dart';

class SignupCZ extends StatefulWidget {
  const SignupCZ({super.key});

  @override
  State<SignupCZ> createState() => _SignupCZState();
}

class _SignupCZState extends State<SignupCZ> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();

  signupCZ() async {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
      Get.offAll(Warpper());
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          ),
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return PopupMenuButton(
                color: Color.fromRGBO(141, 179, 156, 1),
                icon: Icon(Icons.language),
                iconColor: Color.fromRGBO(141, 179, 156, 1),
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey)
            ),
                itemBuilder:  (context) => [
              PopupMenuItem(
                child: 
                Text("English"),
                textStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                ),
               PopupMenuItem(
                child: 
                Text("Čeština "),
                textStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignupCZ()),
                  );
                },
                ),
            ],
            );
            }
          ),
     ),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _login(context),
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
            "Vítejte!",///////////////////////////////////////////////////NADPIS
            style:
            TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(63, 80, 66, 1),
          ),
        ),
          Text("Pro registraci vyplňte níže uvedená pole.",
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
              hintText: "Email",
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
     
         TextField(
          controller: password,
           decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none
              ),
             fillColor: Color.fromRGBO(107, 143, 113, 0.1),
             filled: true,
             prefixIcon: Icon(Icons.password),
             ),
             obscureText: true,
          ),
     
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: (()=>signupCZ()), 
            child: Text("Zaregistrovat",
            style: 
            TextStyle(
              color: Color.fromRGBO(185, 245, 216, 1),
              fontSize: 20,
              fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(107, 143, 113, 1),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 16),
            )
           )
        ],
     ),
   );
  }

  _login(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Máte účet?", 
        style: 
        TextStyle(
          color: Color.fromRGBO(63, 80, 66, 1),),),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CzLoginPage()),
            );
          }, 
        child: Text("Přihlásit se",
        style: TextStyle(color: Color.fromRGBO(141, 179, 156, 1)),))
        )
      ],
    );
  }
}