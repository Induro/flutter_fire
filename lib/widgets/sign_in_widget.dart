import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'app_bar_widget.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                child: const Text('Continue with Google'))
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle(context) async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.addScope('https://www.googleapis.com/auth/userinfo.profile');
    googleProvider.addScope('email');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithPopup(googleProvider);

    Navigator.of(context).pushReplacementNamed('/contacts');
  }
}
