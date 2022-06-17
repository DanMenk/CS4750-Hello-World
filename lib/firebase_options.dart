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
    apiKey: 'AIzaSyCiKig6SigxPr4xumWu8A58Sg739a5IABw',
    appId: '1:1024189305437:android:dad2911bde5bab146973b4',
    messagingSenderId: '1024189305437',
    projectId: 'recipe-randomizer-97e02',
    databaseURL: 'https://recipe-randomizer-97e02-default-rtdb.firebaseio.com',
    storageBucket: 'recipe-randomizer-97e02.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXSFpefn7_cqPTayS1QjOU61ZfMZbjt_4',
    appId: '1:1024189305437:ios:2aa10b0aef0063e06973b4',
    messagingSenderId: '1024189305437',
    projectId: 'recipe-randomizer-97e02',
    databaseURL: 'https://recipe-randomizer-97e02-default-rtdb.firebaseio.com',
    storageBucket: 'recipe-randomizer-97e02.appspot.com',
    iosClientId: '1024189305437-rfrviu7stqgksmrg90hksfeictqaevsm.apps.googleusercontent.com',
    iosBundleId: 'edu.cpp.recipeRan',
  );
}
