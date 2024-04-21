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
        return macos;
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
    apiKey: 'AIzaSyDbqW39gYKiR3AL7zUVVW22izpHG5_jgJU',
    appId: '1:556840120196:web:b677913b4700764d46b7d1',
    messagingSenderId: '556840120196',
    projectId: 'lead-2e832',
    authDomain: 'lead-2e832.firebaseapp.com',
    databaseURL: 'https://lead-2e832-default-rtdb.firebaseio.com',
    storageBucket: 'lead-2e832.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAzZB3-2wY1ut8XzoKdqPZ8JIfs8Lu3-k',
    appId: '1:556840120196:android:113ea2e814e8e86e46b7d1',
    messagingSenderId: '556840120196',
    projectId: 'lead-2e832',
    databaseURL: 'https://lead-2e832-default-rtdb.firebaseio.com',
    storageBucket: 'lead-2e832.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxoKOE8B3BYfDwQMxDO2rmcuxGdlkwYys',
    appId: '1:556840120196:ios:722f5ccc36a3a00746b7d1',
    messagingSenderId: '556840120196',
    projectId: 'lead-2e832',
    databaseURL: 'https://lead-2e832-default-rtdb.firebaseio.com',
    storageBucket: 'lead-2e832.appspot.com',
    iosBundleId: 'com.example.leadGen',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxoKOE8B3BYfDwQMxDO2rmcuxGdlkwYys',
    appId: '1:556840120196:ios:722f5ccc36a3a00746b7d1',
    messagingSenderId: '556840120196',
    projectId: 'lead-2e832',
    databaseURL: 'https://lead-2e832-default-rtdb.firebaseio.com',
    storageBucket: 'lead-2e832.appspot.com',
    iosBundleId: 'com.example.leadGen',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDbqW39gYKiR3AL7zUVVW22izpHG5_jgJU',
    appId: '1:556840120196:web:536731154c82c43146b7d1',
    messagingSenderId: '556840120196',
    projectId: 'lead-2e832',
    authDomain: 'lead-2e832.firebaseapp.com',
    databaseURL: 'https://lead-2e832-default-rtdb.firebaseio.com',
    storageBucket: 'lead-2e832.appspot.com',
  );
}
