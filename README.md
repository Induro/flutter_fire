# Flutter Fire

## Environment Prep

- Create public git repository
- Update Flutter and make sure Flutter Doctor is good to go
- sudo gem install xcodeproj
- get vs-code plugins
- Install flutter fire cli: dart pub global activate flutterfire_cli

## Project Setup

- Create flutter project
- Flutter: New Project
```bash
flutter create --platforms=ios,android,web flutter_fire
```
- Run!

## Auth

- Init firebase in project (https://firebase.google.com/docs/flutter/setup?platform=android)
- Set up auth provider (https://firebase.google.com/docs/auth/flutter/start)
  - Enable google auth
- Set up basic routing
- Set up google sign-in (https://firebase.google.com/docs/auth/flutter/federated-auth#google)
- Set up app bar with google sign-out

## Contact List

- Add user to firestore
- Create global contacts list (https://firebase.google.com/docs/firestore/quickstart#dart)
- Filter out self
- Publish to web on firebase hosting

## Conversation

- Create new route and view
- Create message list
- Create input to send message

## Learning Topics

- Firebase Auth
  - Auth providers
  - Auth triggers
  - Custom Claims
- Firestore
  - Rules
  - Indexes
  - Triggers
  - Backup
- Hosting
- Storage
  - Rules
  - Triggers
- App Distribution
- Firefoo

## Schema

- users
- conversations
  - participants: string[]
  - messages: []
    - author: string
    - content: string
    - sentAt: timestamp

## Run

To run the web version:
```bash
flutter run -d chrome
```

To run the android version:
```bash
emulator -list-avds
emulator @<avd_name>
flutter devices
flutter run -d <device-name>
```

To run the iOS version:
```bash
open -a Simulator
flutter devices
flutter run -d <device-name>
```

## Build

To build for web:
```bash
flutter build web
```

To build the APK (found under `build/aap/outputs/apk/release/*`)
```bash
flutter build apk
```