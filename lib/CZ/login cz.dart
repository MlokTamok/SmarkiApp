import 'package:flutter/material.dart';
import 'package:smarkiapp2/forgot_password.dart';
import 'package:smarkiapp2/login.dart';
import 'package:smarkiapp2/CZ/signup%20cz.dart';

class CzLoginPage extends  StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("/assets/Background.png")
            )
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
                    MaterialPageRoute(builder: (context) => LoginPage()),
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
                    MaterialPageRoute(builder: (context) => CzLoginPage()),
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
              _forgotPassword(context),
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
            "Vítejte!",///////////////////////////////////////////////////NADPIS
            style:
            TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(63, 80, 66, 1),
          ),
        ),
          Text("Pro přihlášení vyplňte níže uvedená pole.",
          style: 
          TextStyle(
            color: Color.fromRGBO(63, 80, 66, 1)
            ),),/////////////////////////////////////////////PODNADPIS
        ],
      );
    }
  _inputField(context){
   return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
     children: [
//      IntlPhoneField(//////////////////////////////////////////////YADANI TEL. CISLA
//    decoration: InputDecoration(
//        labelText: 'Phone Number',
//        border: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(18),
//          borderSide: BorderSide.none,
//        ),
//           fillColor: Color.fromRGBO(107, 143, 113, 0.1),
//           filled: true
//        ),
//    initialCountryCode: 'CZ',
//    onChanged: (phone) {
//        print(phone.completeNumber);
//    },
//),

       TextField(
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

       TextField(///////////////////////////////////TEXT BOX NA HESLO
         decoration: InputDecoration(
          labelText: 'Heslo',
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
        ElevatedButton(////////////////////////////////TLACITKO LOGIN
          onPressed: (){}, 
          child: Text("Přihlášení",
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
   );
  }
  
  _forgotPassword(context){
    return TextButton(onPressed: (){
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => ForgotPassword())
        );
      }, 
    child: Text("Zapomenuté heslo?",
    style: 
    TextStyle(
    color: Color.fromRGBO(141, 179, 156, 1)
      )
    )
    );
  }
  _sigup(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Nemáte účet?", 
        style: 
        TextStyle(
          color: Color.fromRGBO(63, 80, 66, 1),),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignupCZ()),
            );
          }, 
          child: Text("Zaregistrujte se",
          style: TextStyle(color: Color.fromRGBO(141, 179, 156, 1)),)),
        )
      ],
    );
  }

}