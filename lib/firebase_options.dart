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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBayWtcjDMz1-ijmIwuPh4oVyFJ6vOl7Wk',
    appId: '1:675919602915:android:1062da3faf08887dded1d6',
    messagingSenderId: '675919602915',
    projectId: 'testing-3a5ec',
    databaseURL: 'https://testing-3a5ec.firebaseio.com',
    storageBucket: 'testing-3a5ec.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCdB3f6wfop3BXjt0lOVFmn8VOyiufMxU',
    appId: '1:675919602915:ios:9823bff9970b66bdded1d6',
    messagingSenderId: '675919602915',
    projectId: 'testing-3a5ec',
    databaseURL: 'https://testing-3a5ec.firebaseio.com',
    storageBucket: 'testing-3a5ec.appspot.com',
    androidClientId: '675919602915-3t5drfm2kd3mc7v6a8cnvm0ikgek4skm.apps.googleusercontent.com',
    iosClientId: '675919602915-d7e43n3klcr456jg9eg1pmrsslv4vo0p.apps.googleusercontent.com',
    iosBundleId: 'com.example.handover',
  );
}
