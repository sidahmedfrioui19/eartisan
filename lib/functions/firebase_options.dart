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
    apiKey: 'AIzaSyBEFPAH21c9iWndtp_DwIstohFxHLFoQDY',
    appId: '1:334674487742:web:592d0ad2fb6448840e71ef',
    messagingSenderId: '334674487742',
    projectId: 'profinder-c46e0',
    authDomain: 'profinder-c46e0.firebaseapp.com',
    storageBucket: 'profinder-c46e0.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFUriY4akHgcUDgEiu38opXxpWXxOMlDs',
    appId: '1:334674487742:android:0a047037084400fe0e71ef',
    messagingSenderId: '334674487742',
    projectId: 'profinder-c46e0',
    storageBucket: 'profinder-c46e0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCt3KSavcOxhMIhGl0n3xDESYuozlY51lo',
    appId: '1:334674487742:ios:6d3413a4bd9109650e71ef',
    messagingSenderId: '334674487742',
    projectId: 'profinder-c46e0',
    storageBucket: 'profinder-c46e0.appspot.com',
    iosBundleId: 'com.example.profinder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCt3KSavcOxhMIhGl0n3xDESYuozlY51lo',
    appId: '1:334674487742:ios:6c9665e112c386420e71ef',
    messagingSenderId: '334674487742',
    projectId: 'profinder-c46e0',
    storageBucket: 'profinder-c46e0.appspot.com',
    iosBundleId: 'com.example.profinder.RunnerTests',
  );
}
