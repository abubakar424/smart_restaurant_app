// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBMfWq-eGrz9zpuTrW-D_MJ68C6Uqx7O7c',
    appId: '1:361572333927:web:ad2d623a978126e5e4d7c2',
    messagingSenderId: '361572333927',
    projectId: 'social-media-app-4960d',
    authDomain: 'social-media-app-4960d.firebaseapp.com',
    storageBucket: 'social-media-app-4960d.firebasestorage.app',
    measurementId: 'G-618D9YWHTC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAN231NeTmt8uC9Uqt4AQOeF2baDihXR-w',
    appId: '1:1039156347082:android:7c4910eddf79e0b175b433',
    messagingSenderId: '1039156347082',
    projectId: 'car-wash-64a7e',
    storageBucket: 'car-wash-64a7e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiyri5zVfr1MH6I2592s3m6xy3jwh3_H4',
    appId: '1:1039156347082:ios:7795f5fca7dfdb8975b433',
    messagingSenderId: '1039156347082',
    projectId: 'car-wash-64a7e',
    storageBucket: 'car-wash-64a7e.appspot.com',
    iosBundleId: 'com.example.restaurantApp',
  );

}