import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/contact.model.dart';
import 'app_bar_widget.dart';

class SignInWidget extends StatelessWidget {
  final db = FirebaseFirestore.instance;

  SignInWidget({super.key});

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
    googleProvider.setCustomParameters({'prompt': 'select_account'});

    User? user;
    try {
      final userCred = await FirebaseAuth.instance.signInWithPopup(googleProvider);
      user = userCred.user;
    } catch (e) {
      print(e);
      return;
    }

    if (user == null) return;
    final ref = db.collection('users').doc(user.uid);
    final doc = await ref.get();
    if (!doc.exists) {
      final contact = Contact(
        id: user.uid,
        name: user.displayName ?? 'He who must not be named',
        photoURL: user.photoURL,
      );
      await ref.set(contact.toFirestore());
    }
    Navigator.of(context).pushReplacementNamed('/contacts');
  }
}
