# flutter_firebase

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


```
flutter pub get 
```
### File Structure 

```
.
├── android                         - It contains files required to run the application on an Android platform.
├── assets                          - It contains all images and fonts of your application.
├── ios                             - It contains files required to run the application on an iOS platform.
└── lib                             - Most important folder in the application, used to write most of the Dart code.
    ├── main.dart                   - Starting point of the application
    ├── firebase_options.dart       - Firebase options file
    ├── Authrouter.dart             - Authentication router file
    ├── HomePage.dart               - Home page file
    ├── RegisterPage.dart           - Register page file
    └── LoginPage.dart              - Login page file
```