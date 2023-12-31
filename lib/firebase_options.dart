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
    apiKey: 'AIzaSyCq9DoqSKX9WRwvoF8ad3s8hPDhP4jsilE',
    appId: '1:761907194377:web:4ec1c7782f52b3eee6a6d8',
    messagingSenderId: '761907194377',
    projectId: 'reddit-clone-8e0d2',
    authDomain: 'reddit-clone-8e0d2.firebaseapp.com',
    storageBucket: 'reddit-clone-8e0d2.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBv2-qv-rsRADKtWn9dIqGq44mdftbPhbY',
    appId: '1:761907194377:android:0da9b8ef8a08b71ae6a6d8',
    messagingSenderId: '761907194377',
    projectId: 'reddit-clone-8e0d2',
    storageBucket: 'reddit-clone-8e0d2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANDDHaUGr12DL-hDQ-vfvrwmo3P4miTek',
    appId: '1:761907194377:ios:0e584c6034c2bbe9e6a6d8',
    messagingSenderId: '761907194377',
    projectId: 'reddit-clone-8e0d2',
    storageBucket: 'reddit-clone-8e0d2.appspot.com',
    iosClientId: '761907194377-704lcjk0u6bp7058al9tflopibc2sjij.apps.googleusercontent.com',
    iosBundleId: 'com.mycompany.redditTutorial',
  );
}
