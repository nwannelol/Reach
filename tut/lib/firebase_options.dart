// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


// ...



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
    apiKey: 'AIzaSyARqRpe-bp16BzGBpBXV63dx_BP1IbK5pM',
    appId: '1:117002025828:web:5066b44f4428378126d871',
    messagingSenderId: '117002025828',
    projectId: 'reach-login-00',
    authDomain: 'reach-login-00.firebaseapp.com',
    storageBucket: 'reach-login-00.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxgEHwTpDcD6bx-0UEek9UpU68flY_8Oo',
    appId: '1:117002025828:android:5722f92a9917912726d871',
    messagingSenderId: '117002025828',
    projectId: 'reach-login-00',
    storageBucket: 'reach-login-00.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBvXhL0K2OLyvUzU_9q4anoW5EAiuCzq8I',
    appId: '1:117002025828:ios:50f32321ad3c63a626d871',
    messagingSenderId: '117002025828',
    projectId: 'reach-login-00',
    storageBucket: 'reach-login-00.appspot.com',
    iosBundleId: 'com.example.tut',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBvXhL0K2OLyvUzU_9q4anoW5EAiuCzq8I',
    appId: '1:117002025828:ios:7a2c27ab04c0e0bf26d871',
    messagingSenderId: '117002025828',
    projectId: 'reach-login-00',
    storageBucket: 'reach-login-00.appspot.com',
    iosBundleId: 'com.example.tut.RunnerTests',
  );
}