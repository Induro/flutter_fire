import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/widgets/sign_in_widget.dart';

import 'firebase_options.dart';
import 'widgets/contacts_widget.dart';
import 'widgets/conversation_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Fire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/contacts',
      // TODO: add guards to prevent unauthorized access
      routes: {
        '/sign-in': (context) => SignInWidget(),
        '/contacts': (context) => ContactsWidget(),
        '/conversation': (context) {
          // TODO: remove the default
          final recipientId = (ModalRoute.of(context)?.settings.arguments) as String;
          return ConversationWidget(recipientId: recipientId);
        }
      },
    );
  }
}
