// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/RegisterPage.dart';
// import 'package:flutter_firebase/HomePage.dart';
import 'package:flutter_firebase/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passToggle = true;
  bool isLoad = false;

  // Sign In Function
  signInWithEmailAndPassword() async {
    try {
      setState(() {
        isLoad = true;
      });
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      setState(() {
        isLoad = false;
      });

      if (credential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoad = false;
      });
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Wrong password provided for that user.")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          // Wrap the title text with Center widget
          child: Text('Login Page'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 40, // Set the font size
                  fontWeight: FontWeight.bold, // Set the font weight (optional)
                  color: Colors.indigo,
                  // You can also set other text styles such as color, font family, etc. here.
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  // You can add more email validation logic here if needed.

                  bool emailValid = RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                      .hasMatch(value!);

                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }

                  if (!emailValid) {
                    return "Enter Valid Email";
                  }

                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: passToggle,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        passToggle = !passToggle;
                      });
                    },
                    child: Icon(
                        passToggle ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  } else if (passwordController.text.length < 4) {
                    return "Password Length Should be more than 4 characters";
                  }
                  // You can add more password validation logic here if needed.
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // call SignIn Function
                    signInWithEmailAndPassword();
                  }
                },
                child: isLoad
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text('Login'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  TextButton(
                    onPressed: () {
                      // Add navigation to the registration page here.
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text("SignUp",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
