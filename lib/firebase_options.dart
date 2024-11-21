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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBLp9hQC23be5t62GCK4yku2brLI7hNtLk',
    appId: '1:851410645369:web:96bedb35d9feb4ebee3fa8',
    messagingSenderId: '851410645369',
    projectId: 'my-shopping-app-85938',
    authDomain: 'my-shopping-app-85938.firebaseapp.com',
    storageBucket: 'my-shopping-app-85938.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVqQuIMCR9X4UX4VJ6JcUeyd_1ifM1C3U',
    appId: '1:851410645369:android:43d9dd4660dfa8acee3fa8',
    messagingSenderId: '851410645369',
    projectId: 'my-shopping-app-85938',
    storageBucket: 'my-shopping-app-85938.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLp9hQC23be5t62GCK4yku2brLI7hNtLk',
    appId: '1:851410645369:web:7d372d0871e01cbbee3fa8',
    messagingSenderId: '851410645369',
    projectId: 'my-shopping-app-85938',
    authDomain: 'my-shopping-app-85938.firebaseapp.com',
    storageBucket: 'my-shopping-app-85938.firebasestorage.app',
  );
}