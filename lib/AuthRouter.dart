import 'package:flutter/material.dart';

import 'package:flutter_firebase/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking the authentication state
            return const CircularProgressIndicator();
          }
          // else {
          //   if (snapshot.hasData) {
          //     // User is logged in, navigate to the home page
          //   } else {
          //     // User is not logged in, navigate to the login page
          //     return HomePage();
          //   }
          // }

          return LoginPage();
        },
      ), // StreamBuilder
    ); // Scaffold
  }
}
