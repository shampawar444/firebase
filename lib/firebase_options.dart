import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDhu2OqEO5XWTnIx3mB_n-O_-up5d3G6zY',
    appId: '1:133744354684:web:59f4546b9062d6519770f9',
    messagingSenderId: '133744354684',
    projectId: 'my-app-5fed2',
    authDomain: 'my-app-5fed2.firebaseapp.com',
    storageBucket: 'my-app-5fed2.firebasestorage.app',
    measurementId: 'G-V2KYP9WYJE',
    databaseURL: 'https://my-app-5fed2-default-rtdb.asia-southeast1.firebasedatabase.app',  // Add this line
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADV4j6hknPlDsFM3xohg-kqnCd3R_0UjA',
    appId: '1:133744354684:android:4db0916258e7ac309770f9',
    messagingSenderId: '133744354684',
    projectId: 'my-app-5fed2',
    storageBucket: 'my-app-5fed2.firebasestorage.app',
    databaseURL: 'https://my-app-5fed2-default-rtdb.asia-southeast1.firebasedatabase.app',  // Add this line
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCq4u8bnIl5M08YxuIa2zqMotp-GexTXfI',
    appId: '1:133744354684:ios:3197f7e931696d309770f9',
    messagingSenderId: '133744354684',
    projectId: 'my-app-5fed2',
    storageBucket: 'my-app-5fed2.firebasestorage.app',
    iosBundleId: 'com.example.firebaseApp',
    databaseURL: 'https://my-app-5fed2-default-rtdb.asia-southeast1.firebasedatabase.app',  // Add this line
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCq4u8bnIl5M08YxuIa2zqMotp-GexTXfI',
    appId: '1:133744354684:ios:3197f7e931696d309770f9',
    messagingSenderId: '133744354684',
    projectId: 'my-app-5fed2',
    storageBucket: 'my-app-5fed2.firebasestorage.app',
    iosBundleId: 'com.example.firebaseApp',
    databaseURL: 'https://my-app-5fed2-default-rtdb.asia-southeast1.firebasedatabase.app',  // Add this line
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDhu2OqEO5XWTnIx3mB_n-O_-up5d3G6zY',
    appId: '1:133744354684:web:de5172fdfc31c3489770f9',
    messagingSenderId: '133744354684',
    projectId: 'my-app-5fed2',
    authDomain: 'my-app-5fed2.firebaseapp.com',
    storageBucket: 'my-app-5fed2.firebasestorage.app',
    measurementId: 'G-89BQ4WPB3T',
    databaseURL: 'https://my-app-5fed2-default-rtdb.asia-southeast1.firebasedatabase.app',  // Add this line
  );
}
