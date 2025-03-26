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

  // REPLACE WITH YOUR ACTUAL FIREBASE PROJECT DETAILS
  // You can find these in your Firebase console -> Project settings -> Your apps
  
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDbgrCPuKS5ogRgG6S0NgA3hdQlXmio4Cs',
    appId: '1:937438115523:web:YOUR_WEB_APP_ID',
    messagingSenderId: '937438115523',
    projectId: 'goalapp-af316',
    authDomain: 'goalapp-af316.firebaseapp.com',
    storageBucket: 'goalapp-af316.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbgrCPuKS5ogRgG6S0NgA3hdQlXmio4Cs',
    appId: '1:937438115523:android:f35395223fd6de96ab1476',
    messagingSenderId: '937438115523',
    projectId: 'goalapp-af316',
    storageBucket: 'goalapp-af316.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR-IOS-API-KEY',
    appId: 'YOUR-IOS-APP-ID',
    messagingSenderId: '937438115523',
    projectId: 'goalapp-af316',
    storageBucket: 'goalapp-af316.firebasestorage.app',
    iosClientId: 'YOUR-IOS-CLIENT-ID',
    iosBundleId: 'apps.goals.goalsapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'YOUR-MACOS-API-KEY',
    appId: 'YOUR-MACOS-APP-ID',
    messagingSenderId: '937438115523',
    projectId: 'goalapp-af316',
    storageBucket: 'goalapp-af316.firebasestorage.app',
    iosClientId: 'YOUR-MACOS-CLIENT-ID',
    iosBundleId: 'apps.goals.goalsapp',
  );
} 