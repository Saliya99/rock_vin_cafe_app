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
    apiKey: 'AIzaSyDxfVXhYjZ08rfU9LKor0n9_BEFABdDD8s',
    appId: '1:1062676055284:android:97bf6e7d58e0f97f624aa1',
    messagingSenderId: '1062676055284',
    projectId: 'rockvin-33f7e',
    storageBucket: 'rockvin-33f7e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBye3nBWg31X3ydeoMMjDtumEaEkqI1ePA',
    appId: '1:1062676055284:ios:850f0986419edb39624aa1',
    messagingSenderId: '1062676055284',
    projectId: 'rockvin-33f7e',
    storageBucket: 'rockvin-33f7e.appspot.com',
    androidClientId: '1062676055284-kea6c3nf771036g7c2jrq3q8526s17ub.apps.googleusercontent.com',
    iosClientId: '1062676055284-7a58i2p1f30ogcq0t2cf5ocv7id06tp8.apps.googleusercontent.com',
    iosBundleId: 'com.example.rockVinCafeApp',
  );
}
