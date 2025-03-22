import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarkiapp2/login.dart';
import 'package:smarkiapp2/warpper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool isloading = false;

  signup() async {
    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match."), duration: Duration(seconds: 2)),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
      Get.offAll(Warpper());
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
    return Container(
      decoration: BoxDecoration(),
      child: Scaffold(
        appBar: AppBar(
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
          "Please fill fields below to sign up.",
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

          TextField(
            controller: confirmPassword,
            obscureText: !_confirmPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              fillColor: Color.fromRGBO(107, 143, 113, 0.1),
              filled: true,
              prefixIcon: Icon(Icons.password),
              suffixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Color.fromRGBO(107, 143, 113, 1),
                ),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible; 
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 10),

          password.text.length < 6
          ? Text(
            'Password must be at least 6 characters long',
            style: TextStyle(color: Colors.red, fontSize: 12),
            )
            : Container(),

          SizedBox(height: 10,),

          ElevatedButton(
            onPressed: signup,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(107, 143, 113, 1),
              shape: StadiumBorder(),
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              "Sign Up",
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

  _login(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(color: Color.fromRGBO(63, 80, 66, 1)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text(
              "Login",
              style: TextStyle(color: Color.fromRGBO(141, 179, 156, 1)),
            ),
          ),
        ),
      ],
    );
  }
}