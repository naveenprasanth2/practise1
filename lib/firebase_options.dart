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
    apiKey: 'AIzaSyCw-PQpoT7X1Ds429IT9SZiAZ0f-rWbm-8',
    appId: '1:1099359424912:web:e6a437fa8d13ec9ae6a315',
    messagingSenderId: '1099359424912',
    projectId: 'bookany',
    authDomain: 'bookany-2a548.firebaseapp.com',
    databaseURL: 'https://bookany-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bookany.appspot.com',
    measurementId: 'G-YP3M9TZ0B5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDbJfa_QC8QnHs6SYIkUhv3Xz-9qlADYg',
    appId: '1:1099359424912:android:28a790e74821dfcbe6a315',
    messagingSenderId: '1099359424912',
    projectId: 'bookany',
    databaseURL: 'https://bookany-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bookany.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADREC4-IaVqly1q1Wt5LkOTGa3xwwT8Ss',
    appId: '1:1099359424912:ios:62712baf4258aebfe6a315',
    messagingSenderId: '1099359424912',
    projectId: 'bookany',
    databaseURL: 'https://bookany-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bookany.appspot.com',
    androidClientId: '1099359424912-da7mg9ifho07hgsfc20d5vmf8pf6fr36.apps.googleusercontent.com',
    iosClientId: '1099359424912-l1gkdk4nieb19vcpn6urq6pl9jng2cev.apps.googleusercontent.com',
    iosBundleId: 'com.bookany.users',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADREC4-IaVqly1q1Wt5LkOTGa3xwwT8Ss',
    appId: '1:1099359424912:ios:e53c4fbde838d023e6a315',
    messagingSenderId: '1099359424912',
    projectId: 'bookany',
    databaseURL: 'https://bookany-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'bookany.appspot.com',
    androidClientId: '1099359424912-da7mg9ifho07hgsfc20d5vmf8pf6fr36.apps.googleusercontent.com',
    iosClientId: '1099359424912-snf0ke634n6qgdc2sd4tph9coa3q6qlj.apps.googleusercontent.com',
    iosBundleId: 'com.example.practise1.RunnerTests',
  );
}
