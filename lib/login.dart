import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smarkiapp2/forgot_password.dart';
import 'package:smarkiapp2/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isloading = false;
  String error = '';
  bool _passwordVisible = false;

void signIn() async {
  if (email.text.isEmpty || password.text.isEmpty) {
    showErrorSnackBar('Please enter both email and password.');
    return;
  }

  setState(() => isloading = true);

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    switch (e.code) {
      case 'wrong-password':
        errorMessage = 'Incorrect password. Please try again.';
        break;
      case 'user-not-found':
        errorMessage = 'No user found with this email.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is not valid.';
        break;
      case 'user-disabled':
        errorMessage = 'This user has been disabled.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many attempts. Try again later.';
        break;
      case 'network-request-failed':
        errorMessage = 'Network error. Check your connection.';
        break;
      default:
        errorMessage = e.message ?? 'An unexpected error occurred.';
    }

    if (mounted) {
      showErrorSnackBar(errorMessage);
    }
  } catch (e) {
    if (mounted) {
      showErrorSnackBar('An error occurred: ${e.toString()}');
    }
  }

  if (mounted) {
    setState(() => isloading = false);
  }
}

void showErrorSnackBar(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: Duration(seconds: 3)),
  );
}


  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(63, 80, 66, 1),
            ),
          )
        : Container(
            decoration: BoxDecoration(),
            child: Scaffold(
              appBar: AppBar(
//                leading: Builder(
//                  builder: (BuildContext context) {
//                    return PopupMenuButton(
//                      color: Color.fromRGBO(141, 179, 156, 1),
//                      icon: Icon(Icons.language),
//                      iconColor: Color.fromRGBO(141, 179, 156, 1),
//                      shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10),
//                        side: BorderSide(color: Colors.grey),
//                      ),
//                      itemBuilder: (context) => [
//                        PopupMenuItem(
//                          child: Text("English"),
//                          textStyle: TextStyle(
//                            color: Color.fromRGBO(255, 255, 255, 1),
//                          ),
//                         onTap: () {
//                            Navigator.pushReplacement(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => LoginPage(),
//                              ),
//                            );
//                          },
//                        ),
//                        PopupMenuItem(
//                          child: Text("Čeština "),
//                          textStyle: TextStyle(
//                            color: Color.fromRGBO(255, 255, 255, 1),
//                          ),
//                         onTap: () {
//                            Navigator.pushReplacement(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => CzLoginPage(),
//                              ),
//                            );
//                          },
//                        ),
//                      ],
//                    );
//                  },
//                ),
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

  _header(context) {
    return Column(
      children: [
        Text(
          "Welcome!",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(63, 80, 66, 1),
          ),
        ),
        Text(
          "Please fill fields below to login.",
          style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1)),
        ),
      ],
    );
  }

  _inputField(context) {
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
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              prefixIcon: Icon(Icons.mail_outline),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 10),


          TextField(
            controller: password,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              prefixIcon: Icon(Icons.password),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color.fromRGBO(107, 143, 113, 1),
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible; 
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 10),

          
          ElevatedButton(
            onPressed: (() => signIn()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(107, 143, 113, 1),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              "Login",
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

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ForgotPassword()),
        );
      },
      child: Text(
        "Forgot password?",
        style: TextStyle(color: Color.fromRGBO(141, 179, 156, 1)),
      ),
    );
  }

  _sigup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Signup()),
              );
            },
            child: Text(
              "Sign Up",
              style: TextStyle(color: Color.fromRGBO(141, 179, 156, 1)),
            ),
          ),
        ),
      ],
    );
  }
}
