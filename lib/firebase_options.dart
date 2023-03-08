// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBBH0y8Pxzu2MuB1p-RP46ylIHc9rRi22w',
    appId: '1:894214969927:web:1d8b379ba4ecaf90aaef62',
    messagingSenderId: '894214969927',
    projectId: 'flutter-fire-dry-run',
    authDomain: 'flutter-fire-dry-run.firebaseapp.com',
    storageBucket: 'flutter-fire-dry-run.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClA8tuzfY-W2c4SK7NQDcTzI5n77ZDBkw',
    appId: '1:894214969927:android:971746365b47bb37aaef62',
    messagingSenderId: '894214969927',
    projectId: 'flutter-fire-dry-run',
    storageBucket: 'flutter-fire-dry-run.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB42-roCCtgUcSoS_3GZjeR58AdM1_JguQ',
    appId: '1:894214969927:ios:9b47d07b369c151daaef62',
    messagingSenderId: '894214969927',
    projectId: 'flutter-fire-dry-run',
    storageBucket: 'flutter-fire-dry-run.appspot.com',
    iosClientId: '894214969927-dc8slf3j0l0ff05741uiiid001ckq6nt.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFire',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB42-roCCtgUcSoS_3GZjeR58AdM1_JguQ',
    appId: '1:894214969927:ios:9b47d07b369c151daaef62',
    messagingSenderId: '894214969927',
    projectId: 'flutter-fire-dry-run',
    storageBucket: 'flutter-fire-dry-run.appspot.com',
    iosClientId: '894214969927-dc8slf3j0l0ff05741uiiid001ckq6nt.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFire',
  );
}