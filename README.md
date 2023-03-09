# Flutter Fire

## Environment Prep

- Create public git repository
- Update Flutter and make sure Flutter Doctor is good to go
- sudo gem install xcodeproj
- get vs-code plugins
- Install flutter fire cli: dart pub global activate flutterfire_cli

## Project Setup

- Create cloud project
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

- Add user to firestore via Firebase Auth trigger (**TODO**)
- Create global contacts list (https://firebase.google.com/docs/firestore/quickstart#dart)
- Filter out self
- Publish to web on firebase hosting (**TODO**)

## Conversation

- Create new route and view
- Create message list
- Create input to send message

## Stretch Goals

- Firestore backup

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