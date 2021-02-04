import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snap) => snap.connectionState == ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : MaterialApp(
              title: 'FlutterChat',
              theme: ThemeData(
                primarySwatch: Colors.pink,
                backgroundColor: Colors.pink,
                accentColor: Colors.deepPurple,
                accentColorBrightness: Brightness.dark,
                buttonTheme: ButtonTheme.of(context).copyWith(
                  buttonColor: Colors.pink,
                  textTheme: ButtonTextTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return SplashScreen();
                  }
                  if (snap.hasData) {
                    return ChatScreen();
                  }
                  return AuthScreen();
                },
              ),
            ),
    );
  }
}
