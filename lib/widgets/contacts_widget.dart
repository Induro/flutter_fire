import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/contact.model.dart';
import 'app_bar_widget.dart';

/*
final data = [
  Contact(id: '1', name: 'Keegan Rice', photoUrl: 'http://placekitten.com/50/50'),
  Contact(id: '2', name: 'Amy Rice', photoUrl: 'http://placekitten.com/50/50'),
  Contact(id: '3', name: 'Bob Rice', photoUrl: 'http://placekitten.com/50/50')
];
*/

class ContactsWidget extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  ContactsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: const AppBarWidget(),
      body: user != null ? buildContactList(user) : const Center(child: Text('Please sign in')),
    );
  }

  Widget buildContactList(User user) {
    final users = db.collection('users').where(Contact.idKey, isNotEqualTo: user.uid).snapshots();
    return StreamBuilder(
      stream: users,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.size == 0) return const Center(child: Text('Do you feel lonely?'));
        final data = snapshot.data!.docs.map((doc) => Contact.fromFirestore(doc.data())).toList();

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final contact = data[index];
            return buildContact(context, contact);
          },
        );
      },
    );
  }

  Widget buildContact(BuildContext context, Contact contact) {
    return ListTile(
      title: Text(contact.name),
      leading: CircleAvatar(
        backgroundImage: contact.photoURL != null ? NetworkImage(contact.photoURL!) : null,
      ),
      onTap: () {
        Navigator.pushNamed(context, '/conversation', arguments: contact.id);
      },
    );
  }
}
