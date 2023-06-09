import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import './firebase_credentials.dart';

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
    apiKey: webFirebaseApiKey,
    appId: webFirebaseAppId,
    messagingSenderId: messagingSenderId,
    projectId: 'mynotesgbarska',
    authDomain: 'mynotesgbarska.firebaseapp.com',
    storageBucket: 'mynotesgbarska.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: androidFirebaseApiKey,
    appId: androidFirebaseAppId,
    messagingSenderId: messagingSenderId,
    projectId: 'mynotesgbarska',
    storageBucket: 'mynotesgbarska.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: iosFirebaseApiKey,
    appId: iosFirebaseAppId,
    messagingSenderId: messagingSenderId,
    projectId: 'mynotesgbarska',
    storageBucket: 'mynotesgbarska.appspot.com',
    iosClientId: '402218717117-jd6klf8i5clu2b3blntd01g76mq8k82v.apps.googleusercontent.com',
    iosBundleId: 'com.ibiuna.mynotes',
  );
}
