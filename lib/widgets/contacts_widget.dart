import 'package:flutter/material.dart';

import 'app_bar_widget.dart';

class Contact {
  Contact({required this.id, required this.name, required this.photoUrl});
  final String id;
  final String name;
  final String photoUrl;
}

final data = [
  Contact(id: '1', name: 'Keegan Rice', photoUrl: 'http://placekitten.com/50/50'),
  Contact(id: '2', name: 'Amy Rice', photoUrl: 'http://placekitten.com/50/50'),
  Contact(id: '3', name: 'Bob Rice', photoUrl: 'http://placekitten.com/50/50')
];

class ContactsWidget extends StatelessWidget {
  const ContactsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final contact = data[index];
            return ListTile(
              title: Text(contact.name),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(contact.photoUrl),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/conversation', arguments: contact.id);
              },
            );
          },
        ));
  }
}
