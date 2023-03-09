import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget with PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: const Text("Flutter Fire"),
      actions: [
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            return buildMenu(context, snapshot.data!);
          },
        )
      ],
    );
  }

  Widget buildMenu(BuildContext context, User user) {
    return PopupMenuButton(
      iconSize: 50,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: TextButton(
              onPressed: () {
                signOut(context);
              },
              child: const Text("Sign Out"),
            ),
          )
        ];
      },
      icon: CircleAvatar(backgroundImage: user.photoURL != null ? NetworkImage(user.photoURL!) : null),
    );
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await Navigator.of(context).pushNamedAndRemoveUntil('/sign-in', (route) => false);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
